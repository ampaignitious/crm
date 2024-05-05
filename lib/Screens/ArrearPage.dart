import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vfu/Controllers/services.dart';
import 'package:vfu/Models/Arrear.dart';
import 'package:vfu/Utils/AppColors.dart';

import '../Widgets/Drawer/DrawerItems.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import '../Util/save_file_mobile.dart' as helper;
import 'package:intl/intl.dart';

class ArrearPage extends StatefulWidget {
  const ArrearPage({super.key});

  @override
  _ArrearPageState createState() => _ArrearPageState();
}

class _ArrearPageState extends State<ArrearPage> {
  late Future<List<Arrear>> arrears;
  late ArrearDataSource arrearDataSource;
  String selectedGroup = 'Officer';

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  @override
  void initState() {
    super.initState();
    arrears = getArrearData();
  }

  Future<void> _exportDataGridToExcel() async {
    final workbook = _key.currentState?.exportToExcelWorkbook();
    if (workbook != null) {
      final bytes = workbook.saveAsStream();
      workbook.dispose();
      await helper.saveAndLaunchFile(bytes, 'DataGrid.xlsx');
    } else {
      print("workbook is null");
    }
  }

  Future<void> _exportDataGridToPdf() async {
    final document =
        _key.currentState?.exportToPdfDocument(fitAllColumnsInOnePage: true);
    if (document != null) {
      final bytes = document.saveSync();
      document.dispose();
      await helper.saveAndLaunchFile(bytes, 'DataGrid.pdf');
    } else {
      print("document is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.contentColorPurple,
        width: size.width * 0.8,
        child: const DrawerItems(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.contentColorPurple,
          size: size.width * 0.11,
        ), // Change the icon color here

        backgroundColor: AppColors.contentColorCyan,

        title: Text(
          "Arrears",
          style: GoogleFonts.lato(
              fontSize: size.width * 0.062,
              color: AppColors.menuBackground,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: arrears,
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

            arrearDataSource =
                ArrearDataSource(arrearData: snapshot.data as List<Arrear>);
            return Column(
              children: [
                // Container(
                //   margin: const EdgeInsets.all(12.0),
                //   child: Row(
                //     children: <Widget>[
                //       SizedBox(
                //         height: 40.0,
                //         width: 150.0,
                //         child: MaterialButton(
                //             color: Colors.blue,
                //             onPressed: _exportDataGridToExcel,
                //             child: const Center(
                //                 child: Text(
                //               'Export to Excel',
                //               style: TextStyle(color: Colors.white),
                //             ))),
                //       ),
                //       const Padding(padding: EdgeInsets.all(20)),
                //       SizedBox(
                //         height: 40.0,
                //         width: 150.0,
                //         child: MaterialButton(
                //             color: Colors.blue,
                //             onPressed: _exportDataGridToPdf,
                //             child: const Center(
                //                 child: Text(
                //               'Export to PDF',
                //               style: TextStyle(color: Colors.white),
                //             ))),
                //       ),
                //     ],
                //   ),
                // ),
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
                          'Officer',
                          'Branch',
                          'Region',
                          'Loan Product',
                          'Gender',
                          'District',
                          'Sub-County',
                          'Age',
                          'Village',
                          'Client'
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
                            arrears = getArrearData();

                            //refresh the data source
                            arrearDataSource = ArrearDataSource(
                                arrearData: snapshot.data as List<Arrear>);

                            //refresh the datagrid
                            _key.currentState?.refresh();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SfDataGrid(
                    source: arrearDataSource,
                    columnWidthMode: ColumnWidthMode.fitByCellValue,
                    frozenColumnsCount: 1, // Number of columns to freeze
                    frozenRowsCount: 1, // Number of rows to freeze
                    //apply pagination
                    allowSorting: true,
                    columns: <GridColumn>[
                      if (selectedGroup == 'Officer')
                        GridColumn(
                            columnName: 'OfficerId',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Officer ID',
                                ))),
                      if (selectedGroup == 'Branch')
                        GridColumn(
                            columnName: 'branchId',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Branch ID',
                                ))),
                      if (selectedGroup == 'Region')
                        GridColumn(
                            columnName: 'regionId',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Region ID',
                                ))),
                      if (selectedGroup == 'Loan Product')
                        GridColumn(
                            columnName: 'loanProduct',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Loan Product',
                                ))),
                      if (selectedGroup == 'Gender')
                        GridColumn(
                            columnName: 'gender',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Gender',
                                ))),
                      if (selectedGroup == 'District')
                        GridColumn(
                            columnName: 'district',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'District',
                                ))),
                      if (selectedGroup == 'Sub-County')
                        GridColumn(
                            columnName: 'subCounty',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Sub-County',
                                ))),
                      if (selectedGroup == 'Age')
                        GridColumn(
                            columnName: 'age',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Age',
                                ))),
                      if (selectedGroup == 'Village')
                        GridColumn(
                            columnName: 'village',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Village',
                                ))),
                      if (selectedGroup == 'Client')
                        GridColumn(
                            columnName: 'clientId',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Client ID',
                                ))),
                      GridColumn(
                          columnName: 'name',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Name'))),
                      GridColumn(
                          columnName: 'clients',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Clients',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          columnName: 'outstandingPrincipal',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Outstanding Principal'))),
                      GridColumn(
                          columnName: 'principalArrears',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Principal Arrears'))),
                      GridColumn(
                          columnName: 'interestArrears',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Interest Arrears'))),
                      GridColumn(
                          columnName: 'totalArrears',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Total Arrears'))),
                      GridColumn(
                          columnName: 'clientsInArrears',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Clients In Arrears'))),
                      GridColumn(
                          columnName: 'par1Day',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('PAR>1 Day(%)'))),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  String getActualSelectedValue(String selected) {
    switch (selected) {
      case 'Officer':
        return 'staff_id';
      case 'Branch':
        return 'branch_id';
      case 'Region':
        return 'region_id';
      case 'Loan Product':
        return 'loan_product';
      case 'Gender':
        return 'gender';
      case 'District':
        return 'district';
      case 'Sub-County':
        return 'sub_county';
      case 'Age':
        return 'age';
      case 'Village':
        return 'village';
      case 'Client':
        return 'client';
      default:
        return 'staff_id';
    }
  }

  Future<List<Arrear>> getArrearData() async {
    try {
      AuthController authController = AuthController();

      final response = await authController
          .getArrears(getActualSelectedValue(selectedGroup));
      final arrearsData = response['data'] as List;
      final arrears = arrearsData.map((data) {
        try {
          return Arrear.fromJson(data);
        } catch (e) {
          // Consider returning a placeholder object or handling differently
          return Arrear("0", "0", "0", "0", "0", "0", "0", "0", "0",
              "0"); // Placeholder values
        }
      }).toList();
      return arrears;
    } catch (e) {
      return [];
    }
  }
}

/// An object to set the arrear collection data source to the datagrid. This
/// is used to map the arrear data to the datagrid widget.
class ArrearDataSource extends DataGridSource {
  /// Creates the arrear data source class with required details.
  ArrearDataSource({required List<Arrear> arrearData, String? groupBy}) {
    _arrearData = arrearData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'OfficerId', value: e.OfficerId),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'clients', value: e.clients),
              DataGridCell<String>(
                  columnName: 'outstandingPrincipal',
                  value: e.outstandingPrincipal),
              DataGridCell<String>(
                  columnName: 'principalArrears', value: e.principalArrears),
              DataGridCell<String>(
                  columnName: 'interestArrears', value: e.interestArrears),
              DataGridCell<String>(
                  columnName: 'totalArrears', value: e.totalArrears),
              DataGridCell<String>(
                  columnName: 'clientsInArrears', value: e.clientsInArrears),
              DataGridCell<String>(columnName: 'par1Day', value: e.par1Day),
            ]))
        .toList();
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
        'clients',
        'outstandingPrincipal',
        'principalArrears',
        'interestArrears',
        'totalArrears',
        'clientsInArrears'
      ].contains(e.columnName)) {
        // Check if the value is numeric and can be formatted
        if (double.tryParse(e.value.toString()) != null) {
          // Format numeric values
          final formattedValue =
              formatter.format(double.parse(e.value.toString()));
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
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
