import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vfu/Controllers/services.dart';
import 'package:vfu/Models/Expected.dart';
import 'package:vfu/Utils/AppColors.dart';

import '../Widgets/Drawer/DrawerItems.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import '../Util/save_file_mobile.dart' as helper;

class ExpectedRepayments extends StatefulWidget {
  const ExpectedRepayments({super.key});

  @override
  _ExpectedRepaymentsState createState() => _ExpectedRepaymentsState();
}

class _ExpectedRepaymentsState extends State<ExpectedRepayments> {
  late Future<List<Expected>> expecteds;
  late ExpectedDataSource expectedDataSource;
  String selectedGroup = 'Officer';

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  @override
  void initState() {
    super.initState();
    expecteds = getExpectedData();
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
          "Expected Repayments",
          style: GoogleFonts.lato(
              fontSize: size.width * 0.062,
              color: AppColors.menuBackground,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: expecteds,
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

            expectedDataSource = ExpectedDataSource(
                arrearData: snapshot.data as List<Expected>,
                groupBy: selectedGroup);

            log("selected group here:$selectedGroup");
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
                          'Sub County',
                          'Age'
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
                            expecteds = getExpectedData();

                            //refresh the data source
                            expectedDataSource = ExpectedDataSource(
                                arrearData: snapshot.data as List<Expected>,
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
    if (selectedGroup == 'Officer') {
      widget = Expanded(
        child: SfDataGrid(
          source: expectedDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
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
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Name',
                      overflow: TextOverflow.ellipsis,
                    ))),
            GridColumn(
                columnName: 'clients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients'))),
            GridColumn(
                columnName: 'expectedPrincipal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Principal(UGx)'))),
            GridColumn(
                columnName: 'expectedInterest',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Interest(UGx)'))),
            GridColumn(
                columnName: 'expectedTotal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Total(UGx)'))),
            GridColumn(
                columnName: 'clientsInArrears',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients In Arrears'))),
          ],
        ),
      );
    } else if (selectedGroup == 'Branch') {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: expectedDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'branchId',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Branch ID'))),
            GridColumn(
                columnName: 'branchName',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Name'))),
            GridColumn(
                columnName: 'clients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients'))),
            GridColumn(
                columnName: 'expectedPrincipal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Principal(UGx)'))),
            GridColumn(
                columnName: 'expectedInterest',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Interest(UGx)'))),
            GridColumn(
                columnName: 'expectedTotal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Total(UGx)'))),
            GridColumn(
                columnName: 'clientsInArrears',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients In Arrears'))),
          ],
        ),
      );
    } else if (selectedGroup == 'Region') {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: expectedDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'regionId',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Region ID'))),
            GridColumn(
                columnName: 'regionName',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Name'))),
            GridColumn(
                columnName: 'clients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients'))),
            GridColumn(
                columnName: 'expectedPrincipal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Principal(UGx)'))),
            GridColumn(
                columnName: 'expectedInterest',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Interest(UGx)'))),
            GridColumn(
                columnName: 'expectedTotal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Total(UGx)'))),
            GridColumn(
                columnName: 'clientsInArrears',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients In Arrears'))),
          ],
        ),
      );
    } else if (selectedGroup == 'Loan Product') {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: expectedDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'productName',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Name'))),
            GridColumn(
                columnName: 'clients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients'))),
            GridColumn(
                columnName: 'expectedPrincipal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Principal(UGx)'))),
            GridColumn(
                columnName: 'expectedInterest',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Interest(UGx)'))),
            GridColumn(
                columnName: 'expectedTotal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Total(UGx)'))),
            GridColumn(
                columnName: 'clientsInArrears',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients In Arrears'))),
          ],
        ),
      );
    } else if (selectedGroup == 'District') {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: expectedDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'districtId',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('District ID'))),
            GridColumn(
                columnName: 'name',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Name'))),
            GridColumn(
                columnName: 'clients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients'))),
            GridColumn(
                columnName: 'expectedPrincipal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Principal(UGx)'))),
            GridColumn(
                columnName: 'expectedInterest',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Interest(UGx)'))),
            GridColumn(
                columnName: 'expectedTotal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Total(UGx)'))),
            GridColumn(
                columnName: 'clientsInArrears',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients In Arrears'))),
          ],
        ),
      );
    } else if (selectedGroup == 'Gender') {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: expectedDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'name',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Name'))),
            GridColumn(
                columnName: 'clients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients'))),
            GridColumn(
                columnName: 'expectedPrincipal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Principal(UGx)'))),
            GridColumn(
                columnName: 'expectedInterest',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Interest(UGx)'))),
            GridColumn(
                columnName: 'expectedTotal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Total(UGx)'))),
            GridColumn(
                columnName: 'clientsInArrears',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients In Arrears'))),
          ],
        ),
      );
    } else if (selectedGroup == 'Sub County') {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: expectedDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'subcountyId',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Sub County ID'))),
            GridColumn(
                columnName: 'name',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Name'))),
            GridColumn(
                columnName: 'clients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients'))),
            GridColumn(
                columnName: 'expectedPrincipal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Principal(UGx)'))),
            GridColumn(
                columnName: 'expectedInterest',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Interest(UGx)'))),
            GridColumn(
                columnName: 'expectedTotal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Total(UGx)'))),
            GridColumn(
                columnName: 'clientsInArrears',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients In Arrears'))),
          ],
        ),
      );
    } else if (selectedGroup == 'Age') {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: expectedDataSource,
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          frozenColumnsCount: 1, // Number of columns to freeze
          frozenRowsCount: 1, // Number of rows to freeze
          //apply pagination
          allowSorting: true,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'name',
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Age Bracket'))),
            GridColumn(
                columnName: 'clients',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients'))),
            GridColumn(
                columnName: 'expectedPrincipal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Principal(UGx)'))),
            GridColumn(
                columnName: 'expectedInterest',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Interest(UGx)'))),
            GridColumn(
                columnName: 'expectedTotal',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Expected Total(UGx)'))),
            GridColumn(
                columnName: 'clientsInArrears',
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                label: Container(
                    padding: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: const Text('Clients In Arrears'))),
          ],
        ),
      );
    } else {
      widget = Expanded(
        child: SfDataGrid(
          key: _key,
          source: expectedDataSource,
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
      case 'Sub County':
        return 'sub_county';
      case 'Age':
        return 'age';
      default:
        return 'staff_id';
    }
  }

  Future<List<Expected>> getExpectedData() async {
    try {
      AuthController authController = AuthController();

      final response = await authController
          .getExpected(getActualSelectedValue(selectedGroup));
      final expectedsData = response['data'] as List;
      final expecteds = expectedsData.map((data) {
        try {
          final expecteds = Expected.fromJson(data);
          return expecteds;
        } catch (e) {
          // Consider returning a placeholder object or handling differently
          return Expected(); // Placeholder values
        }
      }).toList();
      return expecteds;
    } catch (e) {
      return [];
    }
  }
}

/// An object to set the arrear collection data source to the datagrid. This
/// is used to map the arrear data to the datagrid widget.
class ExpectedDataSource extends DataGridSource {
  /// Creates the arrear data source class with required details.
  ExpectedDataSource(
      {required List<Expected> arrearData, required String groupBy}) {
    if (groupBy == 'Officer') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'officerId', value: e.groupId),
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell<String>(
                    columnName: 'clients', value: e.totalClients),
                DataGridCell<String>(
                    columnName: 'expectedPrincipal',
                    value: e.expectedPrincipal),
                DataGridCell<String>(
                    columnName: 'expectedInterest', value: e.expectedInterest),
                DataGridCell<String>(
                    columnName: 'expectedTotal', value: e.expectedTotal),
                DataGridCell<String>(
                    columnName: 'clientsInArrears', value: e.clientsInArrears)
              ]))
          .toList();
    } else if (groupBy == 'Branch') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'branchId', value: e.groupId),
                DataGridCell<String>(columnName: 'branchName', value: e.name),
                DataGridCell<String>(
                    columnName: 'clients', value: e.totalClients),
                DataGridCell<String>(
                    columnName: 'expectedPrincipal',
                    value: e.expectedPrincipal),
                DataGridCell<String>(
                    columnName: 'expectedInterest', value: e.expectedInterest),
                DataGridCell<String>(
                    columnName: 'expectedTotal', value: e.expectedTotal),
                DataGridCell<String>(
                    columnName: 'clientsInArrears', value: e.clientsInArrears)
              ]))
          .toList();
    } else if (groupBy == 'Region') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'regionId', value: e.groupId),
                DataGridCell<String>(columnName: 'regionName', value: e.name),
                DataGridCell<String>(
                    columnName: 'clients', value: e.totalClients),
                DataGridCell<String>(
                    columnName: 'expectedPrincipal',
                    value: e.expectedPrincipal),
                DataGridCell<String>(
                    columnName: 'expectedInterest', value: e.expectedInterest),
                DataGridCell<String>(
                    columnName: 'expectedTotal', value: e.expectedTotal),
                DataGridCell<String>(
                    columnName: 'clientsInArrears', value: e.clientsInArrears)
              ]))
          .toList();
    } else if (groupBy == 'Loan Product') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'productName', value: e.name),
                DataGridCell<String>(
                    columnName: 'clients', value: e.totalClients),
                DataGridCell<String>(
                    columnName: 'expectedPrincipal',
                    value: e.expectedPrincipal),
                DataGridCell<String>(
                    columnName: 'expectedInterest', value: e.expectedInterest),
                DataGridCell<String>(
                    columnName: 'expectedTotal', value: e.expectedTotal),
                DataGridCell<String>(
                    columnName: 'clientsInArrears', value: e.clientsInArrears)
              ]))
          .toList();
    } else if (groupBy == 'Gender') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'name', value: e.groupId),
                DataGridCell<String>(
                    columnName: 'clients', value: e.totalClients),
                DataGridCell<String>(
                    columnName: 'expectedPrincipal',
                    value: e.expectedPrincipal),
                DataGridCell<String>(
                    columnName: 'expectedInterest', value: e.expectedInterest),
                DataGridCell<String>(
                    columnName: 'expectedTotal', value: e.expectedTotal),
                DataGridCell<String>(
                    columnName: 'clientsInArrears', value: e.clientsInArrears)
              ]))
          .toList();
    } else if (groupBy == 'District') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'districtId', value: e.groupId),
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell<String>(
                    columnName: 'clients', value: e.totalClients),
                DataGridCell<String>(
                    columnName: 'expectedPrincipal',
                    value: e.expectedPrincipal),
                DataGridCell<String>(
                    columnName: 'expectedInterest', value: e.expectedInterest),
                DataGridCell<String>(
                    columnName: 'expectedTotal', value: e.expectedTotal),
                DataGridCell<String>(
                    columnName: 'clientsInArrears', value: e.clientsInArrears)
              ]))
          .toList();
    } else if (groupBy == 'Sub County') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'subcountyId', value: e.groupId),
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell<String>(
                    columnName: 'clients', value: e.totalClients),
                DataGridCell<String>(
                    columnName: 'expectedPrincipal',
                    value: e.expectedPrincipal),
                DataGridCell<String>(
                    columnName: 'expectedInterest', value: e.expectedInterest),
                DataGridCell<String>(
                    columnName: 'expectedTotal', value: e.expectedTotal),
                DataGridCell<String>(
                    columnName: 'clientsInArrears', value: e.clientsInArrears)
              ]))
          .toList();
    } else if (groupBy == 'Age') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'name', value: e.groupId),
                DataGridCell<String>(
                    columnName: 'clients', value: e.totalClients),
                DataGridCell<String>(
                    columnName: 'expectedPrincipal',
                    value: e.expectedPrincipal),
                DataGridCell<String>(
                    columnName: 'expectedInterest', value: e.expectedInterest),
                DataGridCell<String>(
                    columnName: 'expectedTotal', value: e.expectedTotal),
                DataGridCell<String>(
                    columnName: 'clientsInArrears', value: e.clientsInArrears)
              ]))
          .toList();
    } else {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'officerId', value: e.groupId),
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell<String>(
                    columnName: 'clients', value: e.totalClients),
                DataGridCell<String>(
                    columnName: 'expectedPrincipal',
                    value: e.expectedPrincipal),
                DataGridCell<String>(
                    columnName: 'expectedInterest', value: e.expectedInterest),
                DataGridCell<String>(
                    columnName: 'expectedTotal', value: e.expectedTotal),
                DataGridCell<String>(
                    columnName: 'clientsInArrears', value: e.clientsInArrears)
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
        'clients',
        'expectedPrincipal',
        'expectedInterest',
        'expectedTotal',
        'clientsInArrears'
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
