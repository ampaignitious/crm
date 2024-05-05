import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vfu/Utils/AppColors.dart';

import '../Widgets/Drawer/DrawerItems.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

//import save_file_mobile as helper
import '../Util/save_file_mobile.dart' as helper;

/// The home page of the application which hosts the datagrid.
class CalculatorPage extends StatefulWidget {
  /// Creates the home page.
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  Future<void> _exportDataGridToExcel() async {
    print(_key.currentState);
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
          "Calculators",
          style: GoogleFonts.lato(
              fontSize: size.width * 0.062,
              color: AppColors.menuBackground,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  width: 150.0,
                  child: MaterialButton(
                      color: Colors.blue,
                      onPressed: _exportDataGridToExcel,
                      child: const Center(
                          child: Text(
                        'Export to Excel',
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                SizedBox(
                  height: 40.0,
                  width: 150.0,
                  child: MaterialButton(
                      color: Colors.blue,
                      onPressed: _exportDataGridToPdf,
                      child: const Center(
                          child: Text(
                        'Export to PDF',
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
              ],
            ),
          ),
          Expanded(
            child: SfDataGrid(
              source: employeeDataSource,
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              frozenColumnsCount: 1, // Number of columns to freeze
              frozenRowsCount: 1, // Number of rows to freeze
              //apply pagination
              allowSorting: true,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'OfficerId',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Officer ID',
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
                    columnName: 'principalCalculators',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Principal Calculators'))),
                GridColumn(
                    columnName: 'interestCalculators',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Interest Calculators'))),
                GridColumn(
                    columnName: 'totalCalculators',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Total Calculators'))),
                GridColumn(
                    columnName: 'clientsInCalculators',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Clients In Calculators'))),
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
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(
          '1', 'John', '10', '475,809,900', '100', '100', '200', '5', '10'),
      Employee(
          '2', 'Peter', '20', '475,809,900', '200', '200', '400', '10', '20'),
      Employee(
          '3', 'Andrew', '30', '475,809,900', '300', '300', '600', '15', '30'),
      Employee(
          '4', 'Paul', '40', '475,809,900', '400', '400', '800', '20', '40'),
      Employee('5', 'Philip', '50', '5000', '500', '500', '1000', '25', '50'),
      Employee('6', 'James', '60', '6000', '600', '600', '1200', '30', '60'),
      Employee('7', 'Thomas', '70', '7000', '700', '700', '1400', '35', '70'),
      Employee('8', 'Mathew', '80', '8000', '800', '800', '1600', '40', '80'),
      Employee(
          '9', 'Bartholomew', '90', '9000', '900', '900', '1800', '45', '90'),
      Employee(
          '10', 'Simon', '100', '10000', '1000', '1000', '2000', '50', '100'),
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(
      this.OfficerId,
      this.name,
      this.clients,
      this.outstandingPrincipal,
      this.principalCalculators,
      this.interestCalculators,
      this.totalCalculators,
      this.clientsInCalculators,
      this.par1Day);

  /// Id of an employee.
  final String OfficerId;
  final String name;
  final String clients;
  final String outstandingPrincipal;
  final String principalCalculators;
  final String interestCalculators;
  final String totalCalculators;
  final String clientsInCalculators;
  final String par1Day;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.OfficerId),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'clients', value: e.clients),
              DataGridCell<String>(
                  columnName: 'outstandingPrincipal',
                  value: e.outstandingPrincipal),
              DataGridCell<String>(
                  columnName: 'principalCalculators',
                  value: e.principalCalculators),
              DataGridCell<String>(
                  columnName: 'interestCalculators',
                  value: e.interestCalculators),
              DataGridCell<String>(
                  columnName: 'totalCalculators', value: e.totalCalculators),
              DataGridCell<String>(
                  columnName: 'clientsInCalculators',
                  value: e.clientsInCalculators),
              DataGridCell<String>(columnName: 'par1Day', value: e.par1Day),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
