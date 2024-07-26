import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vfu/Controllers/services.dart';
import 'package:vfu/Models/Sale.dart';
import 'package:vfu/Utils/AppColors.dart';

import '../Widgets/Drawer/DrawerItems.dart';

import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/pdf_document/pdf_document.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SalesTrackerPage extends StatefulWidget {
  const SalesTrackerPage({super.key});

  @override
  _SalesTrackerPageState createState() => _SalesTrackerPageState();
}

class _SalesTrackerPageState extends State<SalesTrackerPage> {
  late Future<List<Sale>> sales;
  late SaleDataSource saleDataSource;
  String selectedGroup = 'Product';

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    super.initState();
    sales = getSaleData();
  }

  Future<void> exportDataGridToExcel() async {
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();

    // Get the temporary directory path
    final directory = await getTemporaryDirectory();
    // Generate the file path using the current date and time
    final path = '${directory.path}/Arrear_${DateTime.now()}.xlsx';

    // Write the file
    File(path).writeAsBytes(bytes).then((_) {
      // Open the file using platform agnostic API
      OpenFile.open(path);
    });

    workbook.dispose();
  }

  Future<void> _exportDataGridToPdf() async {
    final PdfDocument document =
        _key.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true);

    final List<int> bytes = document.saveSync();
    // Get the temporary directory path
    final directory = await getTemporaryDirectory();

    // generate the file path using the current date and time
    final path = '${directory.path}/Arrear_${DateTime.now()}.pdf';

    File(path).writeAsBytes(bytes).then((_) {
      // Open the file using platform agnostic API
      OpenFile.open(path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.contentColorOrange,
        width: size.width * 0.8,
        child: const DrawerItems(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.contentColorOrange,
          size: size.width * 0.11,
        ), // Change the icon color here

        backgroundColor: AppColors.contentColorCyan,

        title: Text(
          "Disbursement Tracker",
          style: GoogleFonts.lato(
              fontSize: size.width * 0.062,
              color: AppColors.menuBackground,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: sales,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            //check if there is an error
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            //check if data is empty
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data found'),
              );
            }

            saleDataSource = SaleDataSource(
                arrearData: snapshot.data as List<Sale>,
                groupBy: selectedGroup);
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: MaterialButton(
                            color: AppColors.contentColorOrange,
                            onPressed: () {
                              exportDataGridToExcel();
                            },
                            child: const Center(
                              child: Icon(
                                Icons.description,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20), // Adjusted to SizedBox
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: MaterialButton(
                            color: AppColors.contentColorOrange,
                            onPressed: _exportDataGridToPdf,
                            child: const Center(
                              child: Icon(
                                Icons.picture_as_pdf,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //add a dropdown to select the group
                Container(
                  margin: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        'Group By:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const Padding(padding: EdgeInsets.all(20)),
                      DropdownButton<String>(
                        items: <String>[
                          'Product',
                          'Branch->Loan Disbursed',
                          'Branch->Clients',
                          'Officer',
                          'Region->Loan Disbursed',
                          'Region->Clients',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: selectedGroup,
                        onChanged: (value) {
                          //set the value to the selected value
                          setState(() {
                            selectedGroup = value!;

                            //refresh the future builder
                            sales = getSaleData();

                            //refresh the data source
                            saleDataSource = SaleDataSource(
                                arrearData: snapshot.data as List<Sale>,
                                groupBy: selectedGroup);

                            //refresh the datagrid
                            _key.currentState?.refresh();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                getGridColumn(selectedGroup),
              ],
            );
          }),
    );
  }

//create a widget of grid column depending on the selected group
  Widget getGridColumn(String selectedGroup) {
    Widget widget;
    if (selectedGroup == 'Product') {
      widget = Expanded(
        child: SfDataGrid(
          source: saleDataSource,
          columnWidthMode: ColumnWidthMode.auto,
          //apply pagination
          allowSorting: true,
          key: _key,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'productName',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Product'))),
            GridColumn(
                columnName: 'actualClients',
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Actual Clients',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'actualVolume',
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Actual Volume(UGx)'))),
            GridColumn(
                columnName: 'targetVolume',
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Target Volume(UGx)'))),
            GridColumn(
                columnName: 'variance',
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Variance(UGx)'))),
            GridColumn(
                columnName: 'score',
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Score(%)'))),
          ],
        ),
      );
    } else if (selectedGroup == 'Branch->Loan Disbursed') {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: saleDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'branchName',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Branch'))),
            GridColumn(
                columnName: 'regionName',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Region'))),
            GridColumn(
                columnName: 'actualVolume',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Actual Volume(UGx)'))),
            GridColumn(
                columnName: 'targetVolume',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Target Volume(UGx)'))),
            GridColumn(
                columnName: 'variance',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Variance(UGx)'))),
            GridColumn(
                columnName: 'score',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Score(%)'))),
          ],
        ),
      );
    } else if (selectedGroup == 'Branch->Clients') {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: saleDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'branchName',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Branch'))),
            GridColumn(
                columnName: 'regionName',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Region'))),
            GridColumn(
                columnName: 'actualClients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Actual Clients'))),
            GridColumn(
                columnName: 'targetClients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Target Clients'))),
            GridColumn(
                columnName: 'variance',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Variance'))),
            GridColumn(
                columnName: 'score',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Score(%)'))),
          ],
        ),
      );
    } else if (selectedGroup == 'Region->Loan Disbursed') {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: saleDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'regionName',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Region'))),
            GridColumn(
                columnName: 'actualVolume',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Actual Volume(UGx)'))),
            GridColumn(
                columnName: 'targetVolume',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Target Volume(UGx)'))),
            GridColumn(
                columnName: 'variance',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Variance(UGx)'))),
            GridColumn(
                columnName: 'score',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Score(%)'))),
          ],
        ),
      );
    } else if (selectedGroup == 'Region->Clients') {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: saleDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'regionName',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Region'))),
            GridColumn(
                columnName: 'actualClients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Actual Clients'))),
            GridColumn(
                columnName: 'targetClients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Target Clients'))),
            GridColumn(
                columnName: 'variance',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Variance'))),
            GridColumn(
                columnName: 'score',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Score(%)'))),
          ],
        ),
      );
    } else {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: saleDataSource,
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'officerId',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Officer ID'))),
            GridColumn(
                columnName: 'name',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Name'))),
            GridColumn(
                columnName: 'actualVolume',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Volume Disbursed(%)'))),
            GridColumn(
                columnName: 'actualClients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Number Of Clients',
                      overflow: TextOverflow.ellipsis,
                    ))),
          ],
        ),
      );
    }
    return widget;
  }

  String getActualSelectedValue(String selected) {
    switch (selected) {
      case 'Product':
        return 'products';
      case 'Branch->Loan Disbursed':
        return 'branches-loans';
      case 'Branch->Clients':
        return 'branches-clients';
      case 'Officer':
        return 'officers';
      case 'Region->Loan Disbursed':
        return 'regions-loans';
      case 'Region->Clients':
        return 'regions-clients';
      default:
        return 'products';
    }
  }

  Future<List<Sale>> getSaleData() async {
    try {
      AuthController authController = AuthController();

      final response =
          await authController.getSales(getActualSelectedValue(selectedGroup));
      final salesData = response['data'] as List;
      final sales = salesData.map((data) {
        try {
          final sales = Sale.fromJson(data, selectedGroup);
          return sales;
        } catch (e) {
          // Consider returning a placeholder object or handling differently
          return Sale(); // Placeholder values
        }
      }).toList();
      return sales;
    } catch (e) {
      return [];
    }
  }
}

/// An object to set the arrear collection data source to the datagrid. This
/// is used to map the arrear data to the datagrid widget.
class SaleDataSource extends DataGridSource {
  /// Creates the arrear data source class with required details.
  SaleDataSource({required List<Sale> arrearData, required String groupBy}) {
    if (groupBy == 'Product') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'productName', value: e.productName),
                DataGridCell<String>(
                    columnName: 'actualClients', value: e.actualClients),
                DataGridCell<String>(
                    columnName: 'actualVolume',
                    value: e.totalDisbursementAmount),
                DataGridCell<String>(
                    columnName: 'targetVolume', value: e.targetAmount),
                DataGridCell<String>(columnName: 'variance', value: e.balance),
                DataGridCell<String>(columnName: 'score', value: e.score),
              ]))
          .toList();

    } else if (groupBy == 'Branch->Loan Disbursed') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'branchName', value: e.branchName),
                DataGridCell<String>(
                    columnName: 'regionName', value: e.regionName),
                DataGridCell<String>(
                    columnName: 'actualVolume',
                    value: e.totalDisbursementAmount),
                DataGridCell<String>(
                    columnName: 'targetVolume', value: e.targetAmount),
                DataGridCell<String>(columnName: 'variance', value: e.balance),
                DataGridCell<String>(columnName: 'score', value: e.score),
              ]))
          .toList();
    } else if (groupBy == 'Branch->Clients') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'branchName', value: e.branchName),
                DataGridCell<String>(
                    columnName: 'regionName', value: e.regionName),
                DataGridCell<String>(
                    columnName: 'actualClients', value: e.actualClients),
                DataGridCell<String>(
                    columnName: 'targetClients', value: e.targetClients),
                DataGridCell<String>(columnName: 'variance', value: e.balance),
                DataGridCell<String>(columnName: 'score', value: e.score),
              ]))
          .toList();
    } else if (groupBy == 'Region->Loan Disbursed') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'regionName', value: e.regionName),
                DataGridCell<String>(
                    columnName: 'actualVolume',
                    value: e.totalDisbursementAmount),
                DataGridCell<String>(
                    columnName: 'targetVolume', value: e.targetAmount),
                DataGridCell<String>(columnName: 'variance', value: e.balance),
                DataGridCell<String>(columnName: 'score', value: e.score),
              ]))
          .toList();
    } else if (groupBy == 'Region->Clients') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'regionName', value: e.regionName),
                DataGridCell<String>(
                    columnName: 'actualClients', value: e.actualClients),
                DataGridCell<String>(
                    columnName: 'targetClients', value: e.targetClients),
                DataGridCell<String>(columnName: 'variance', value: e.balance),
                DataGridCell<String>(columnName: 'score', value: e.score),
              ]))
          .toList();
    } else if (groupBy == 'Officer') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'officerId', value: e.staffId),
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell<String>(
                    columnName: 'actualVolume',
                    value: e.totalDisbursementAmount),
                DataGridCell<String>(
                    columnName: 'actualClients', value: e.numberOfClients),
              ]))
          .toList();
    }
  }

  List<DataGridRow> _arrearData = [];

  @override
  List<DataGridRow> get rows => _arrearData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final formatter = NumberFormat('#,###'); // Create NumberFormat instance
    //format all the values to have commas except for officer id, name and par1Day

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if ([
        'totalDisbursementAmount',
        'targetAmount',
        'balance',
        'targetClients',
        'actualClients',
        'numberOfClients',
        'actualVolume',
        'targetVolume',
        'variance',
        'score'
      ].contains(e.columnName)) {
        // Check if the value is numeric and can be formatted
        if (double.tryParse(e.value.toString()) != null) {
          // Format numeric values
          final formattedValue =
              formatter.format(double.parse(e.value.toString()));
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4.0),
            child: Text(formattedValue),
          );
        }
      }
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
