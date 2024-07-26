import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vfu/Controllers/services.dart';
import 'package:vfu/Models/Monitor.dart';
import 'package:vfu/Utils/AppColors.dart';

import '../Widgets/Drawer/DrawerItems.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/pdf_document/pdf_document.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart' as pdf;

class AppraisalPage extends StatefulWidget {
  const AppraisalPage({super.key});

  @override
  _AppraisalPageState createState() => _AppraisalPageState();
}

class _AppraisalPageState extends State<AppraisalPage> {
  late Future<List<Monitor>> monitors;
  late MonitorDataSource arrearDataSource;

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  @override
  void initState() {
    super.initState();
    monitors = getMonitorData();
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
    final PdfDocument document = _key.currentState!.exportToPdfDocument(
      fitAllColumnsInOnePage: true,
      //set the header to "All Sales Activity"
      headerFooterExport:
          (DataGridPdfHeaderFooterExportDetails headerFooterExport) {
        final double width = headerFooterExport.pdfPage.getClientSize().width;
        final pdf.PdfPageTemplateElement header =
            pdf.PdfPageTemplateElement(Rect.fromLTWH(0, 0, width, 65));
        header.graphics.drawString(
          'Appraisal Activity Sales Summary',
          pdf.PdfStandardFont(pdf.PdfFontFamily.helvetica, 13,
              style: pdf.PdfFontStyle.bold),
          bounds: const Rect.fromLTWH(0, 25, 500, 60),
        );
        headerFooterExport.pdfDocumentTemplate.top = header;
      },
    );

    //set the page orientation to landscape
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
      body: FutureBuilder(
          future: monitors,
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
                MonitorDataSource(monitorData: snapshot.data as List<Monitor>);
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
                Expanded(
                  child: SfDataGrid(
                    key: _key,
                    source: arrearDataSource,
                    columnWidthMode: ColumnWidthMode.fitByCellValue,
                    frozenColumnsCount: 1, // Number of columns to freeze
                    frozenRowsCount: 1, // Number of rows to freeze
                    //apply pagination
                    allowSorting: true,
                    columns: <GridColumn>[
                      GridColumn(
                          columnWidthMode: ColumnWidthMode.auto,
                          columnName: 'id',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('ID'))),
                      GridColumn(
                          columnName: 'name',
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Name'))),
                      GridColumn(
                          columnName: 'phone',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Phone',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          columnName: 'location',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Location'))),
                      GridColumn(
                          columnName: 'activity',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Activity'))),
                      GridColumn(
                          columnName: 'marketingDate',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Marketing Date'))),
                      GridColumn(
                          columnName: 'appraisalDate',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Appraisal Date'))),
                      GridColumn(
                          columnName: 'applicationDate',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Application Date'))),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Future<List<Monitor>> getMonitorData() async {
    try {
      AuthController authController = AuthController();

      final response = await authController.getMonitors("Appraisal");
      final arrearsData = response['monitors'] as List;
      final monitors = arrearsData.map((data) {
        try {
          return Monitor.fromJson(data);
        } catch (e) {
          // Consider returning a placeholder object or handling differently
          return Monitor(
              1, "No records", "", "", "", "", "", ""); // Placeholder values
        }
      }).toList();
      return monitors;
    } catch (e) {
      return [];
    }
  }
}

/// An object to set the arrear collection data source to the datagrid. This
/// is used to map the arrear data to the datagrid widget.
class MonitorDataSource extends DataGridSource {
  /// Creates the arrear data source class with required details.
  MonitorDataSource({required List<Monitor> monitorData}) {
    _monitorData = monitorData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'phone', value: e.phone),
              DataGridCell<String>(columnName: 'location', value: e.location),
              DataGridCell<String>(columnName: 'activity', value: e.activity),
              DataGridCell<String>(
                  columnName: 'marketingDate', value: e.marketingDate),
              DataGridCell<String>(
                  columnName: 'appraisalDate', value: e.appraisalDate),
              DataGridCell<String>(
                  columnName: 'applicationDate', value: e.applicationDate),
            ]))
        .toList();
  }

  List<DataGridRow> _monitorData = [];

  @override
  List<DataGridRow> get rows => _monitorData;

  Future<bool> appraise(monitor_id) async {
    try {
      AuthController authController = AuthController();
      bool response = await authController.appraise(monitor_id);
      return response;
    } catch (e) {
      return false;
    }
  }

  Future<bool> apply(monitor_id) async {
    try {
      AuthController authController = AuthController();
      bool response = await authController.apply(monitor_id);
      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      //if either appraisal date, marketing date or application date is null, return a button with appraise, market and apply
      if (['marketingDate', 'appraisalDate', 'applicationDate']
          .contains(e.columnName)) {
        //check if the value is null
        if (e.value == null) {
          //check if the column name is marketing date and return a button with market
          if (e.columnName == 'marketingDate') {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  //do something
                },
                child: const Text('Market'),
              ),
            );
          }

          //check if the column name is application date and return a button with apply
          if (e.columnName == 'applicationDate') {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  bool response = await apply(row.getCells()[0].value);
                  if (response) {
                    //show success message use Get.snackbar
                    Get.snackbar(
                        'Application', 'Marked to be on Application Stage');
                    Get.offAllNamed('/sales-activity');
                  } else {
                    //show error message use Get.snackbar
                    Get.snackbar('Application',
                        'Marking to be on Application Stage failed, try again later');
                  }
                },
                child: const Text('Apply'),
              ),
            );
          }

          //check if the column name is appraisal date and return a button with appraise
          if (e.columnName == 'appraisalDate') {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  bool response = await appraise(row.getCells()[0].value);
                  if (response) {
                    //show success message use Get.snackbar
                    Get.snackbar(
                        'Appraisal', 'Marked to be on Appraisal Stage');

                    Get.offAllNamed('/sales-activity');
                  } else {
                    //show error message use Get.snackbar
                    Get.snackbar('Appraisal',
                        'Marking to be on Appraisal Stage failed, try again later');
                  }
                },
                child: const Text('Appraise'),
              ),
            );
          }
        } else {
          //modify the value to date format like May 10, 2024, DateFormat('MMM d, yyyy')
          //date in format DateFormat('MMM d, yyyy')
          final date = DateTime.parse(e.value.toString());

          //convert to DateFormat('MMM d, yyyy')
          final formattedDate = DateFormat('MMM d, yyyy').format(date);

          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(formattedDate),
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
