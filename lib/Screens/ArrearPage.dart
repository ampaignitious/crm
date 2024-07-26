import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vfu/Controllers/services.dart';
import 'package:vfu/Models/Arrear.dart';
import 'package:vfu/Utils/AppColors.dart';

import '../Models/Comment.dart';
import '../Widgets/Drawer/DrawerItems.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/pdf_document/pdf_document.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart' as pdf;

class ArrearPage extends StatefulWidget {
  const ArrearPage({super.key});

  @override
  ArrearPageState createState() => ArrearPageState();
}

class ArrearPageState extends State<ArrearPage> {
  late Future<List<Arrear>> arrears;
  late ArrearDataSource arrearDataSource;
  String selectedGroup = 'Client';
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  @override
  void initState() {
    super.initState();
    arrears = getArrearData();
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
          'Arrears Report - Grouped By $selectedGroup',
          pdf.PdfStandardFont(pdf.PdfFontFamily.helvetica, 13,
              style: pdf.PdfFontStyle.bold),
          bounds: const Rect.fromLTWH(0, 25, 800, 60),
        );
        // set the document to landscape
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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.contentColorOrange,
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

            arrearDataSource = ArrearDataSource(
                arrearData: snapshot.data as List<Arrear>,
                groupBy: selectedGroup,
                context: context);
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
                                arrearData: snapshot.data as List<Arrear>,
                                groupBy: selectedGroup,
                                context: context);

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
                    key: _key,
                    columnWidthMode: ColumnWidthMode.fitByCellValue,
                    frozenColumnsCount: 1, // Number of columns to freeze
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
                                  'Customer ID',
                                ))),
                      GridColumn(
                          columnName: 'name',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Names'))),
                      if (selectedGroup == 'Client')
                        GridColumn(
                            columnName: 'comments',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Comments',
                                ))),
                      if (selectedGroup == 'Client')
                        GridColumn(
                            columnName: 'amountDisbursed',
                            columnWidthMode: ColumnWidthMode.auto,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text('Amount Disbursed'))),
                      if (selectedGroup != 'Client')
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
                      if (selectedGroup == 'Client')
                        GridColumn(
                            columnName: 'numberOfDaysLate',
                            columnWidthMode: ColumnWidthMode.auto,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text('Number Of Days Late'))),
                      if (selectedGroup == 'Client')
                        GridColumn(
                            columnName: 'actions',
                            columnWidthMode: ColumnWidthMode.auto,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text('Actions'))),
                      if (selectedGroup != 'Client')
                        GridColumn(
                            columnName: 'clientsInArrears',
                            columnWidthMode: ColumnWidthMode.fitByColumnName,
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: const Text('Clients In Arrears'))),
                      if (selectedGroup != 'Client')
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
          return Arrear("0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
              "0", "0", "0"); // Placeholder values
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
  ArrearDataSource(
      {required List<Arrear> arrearData,
      required String groupBy,
      required BuildContext context}) {
    //Officer
    if (groupBy == 'Officer') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'OfficerId', value: e.OfficerId),
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
    //Branch
    if (groupBy == 'Branch') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'branchId', value: e.OfficerId),
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

    //Region
    if (groupBy == 'Region') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'regionId', value: e.OfficerId),
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

    //Loan Product
    if (groupBy == 'Loan Product') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'loanProduct', value: e.OfficerId),
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

    //Gender
    if (groupBy == 'Gender') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'gender', value: e.OfficerId),
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
    //District
    if (groupBy == 'District') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'district', value: e.OfficerId),
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

    //Sub-County
    if (groupBy == 'Sub-County') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'subCounty', value: e.OfficerId),
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
    //Age
    if (groupBy == 'Age') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'age', value: e.OfficerId),
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
    //Village
    if (groupBy == 'Village') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(columnName: 'village', value: e.OfficerId),
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
    //Client
    if (groupBy == 'Client') {
      _arrearData = arrearData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'clientId', value: e.OfficerId),
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell(columnName: 'comments', value: e.numberOfComments),
                DataGridCell(
                    columnName: 'amountDisbursed', value: e.amountDisbursed),
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
                    columnName: 'numberOfDaysLate', value: e.numberOfDaysLate),
                const DataGridCell<String>(
                    columnName: 'actions', value: 'Actions'),
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
    String customerId = '';
    String numberOfDaysLate = '';

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      //set the customer id
      if (e.columnName == 'OfficerId') {
        customerId = e.value.toString();
      }

      //set the number of days late
      if (e.columnName == 'numberOfDaysLate') {
        numberOfDaysLate = e.value.toString();
      }
      if ([
        'clients',
        'outstandingPrincipal',
        'principalArrears',
        'interestArrears',
        'totalArrears',
        'clientsInArrears',
        'amountDisbursed',
        'numberOfDaysLate'
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

      if (['comments'].contains(e.columnName)) {
        //a small button with number of comments
        return Container(
          // a small button with number of comments
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            //change the background color of the button
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFFE0E0E0)),
            ),
            onPressed: () async {
              AuthController authController = AuthController();
              final response = await authController.showAllComments(customerId);
              final commentsData = response['comments'] as List;
              final comments = commentsData.map((data) {
                try {
                  return Comment.fromJson(data);
                } catch (e) {
                  // Consider returning a placeholder object or handling differently
                  return Comment(0, "0", "0"); // Placeholder values
                }
              }).toList();
              log("Comments: $comments");
              //show a list of comments and dates on which they were added with their bodies
              Get.dialog(SimpleDialog(
                title: Text('Comments'),
                children: comments.map((comment) {
                  //convert createdAt to  like June 1, 2021

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Text('Comment: ${comment.comment}'),
                          Text('Date: ${comment.formattedDate}'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ));
            },
            child: Text(e.value.toString()),
          ),
        );
      }
      if (['actions'].contains(e.columnName)) {
        TextEditingController commentController = TextEditingController();

        //get the current row
        log("e.value: ${e.toString()}");
        //a small button with number of comments
        return Container(
          // a small button with number of comments
          alignment: Alignment.center,
          child: TextButton(
            onPressed: null,
            child: IconButton(
                onPressed: () {
                  Get.dialog(SimpleDialog(
                    title: const Text('Add Comments'),
                    children: <Widget>[
                      //comment box with 12 lines with a round border
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: commentController,
                          maxLines: 12,
                          decoration: const InputDecoration(
                            hintText: 'Enter your comment here',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            //background color of the button
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFFE0E0E0)),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Close',
                                style: TextStyle(
                                    color: AppColors.contentColorOrange)),
                          ),
                          TextButton(
                            //background color of the button
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFFE0E0E0)),
                            ),
                            onPressed: () async {
                              //submit the comment
                              AuthController authController = AuthController();
                              //get customer id from the current row

                              log("Customer ID: $customerId");
                              log("Comment: ${commentController.text}");

                              bool response = await authController.addComment(
                                  commentController.text,
                                  customerId,
                                  numberOfDaysLate);

                              if (response) {
                                //close the dialog
                                Get.back();

                                ///increase the number of comments by 1

                                //show a success message
                                Get.snackbar(
                                    'Success', 'Comment added successfully');
                              } else {
                                //show an error message
                                Get.snackbar('Error', 'Failed to add comment');
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  color: AppColors.contentColorOrange),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
                },
                icon: const Icon(Icons.comment,
                    color: AppColors.contentColorOrange)),
          ),
        );
      }

      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
