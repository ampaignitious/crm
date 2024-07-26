import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vfu/Models/LoanSchedule.dart';
import 'package:vfu/Utils/AppColors.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/pdf_document/pdf_document.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart' as pdf;


class LoanSchedulePage extends StatefulWidget {
  final List<LoanSchedule> loanTable;

  const LoanSchedulePage({Key? key, required this.loanTable}) : super(key: key);

  @override
  _LoanSchedulePageState createState() => _LoanSchedulePageState();
}

class _LoanSchedulePageState extends State<LoanSchedulePage> {
  late LoanScheduleDataSource loanScheduleDataSource;
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  Future<void> exportDataGridToExcel() async {
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();

    // Get the temporary directory path
    final directory = await getTemporaryDirectory();
    // generate the file path using the current date and time
    final path = '${directory.path}/LoanSchedule_${DateTime.now()}.xlsx';

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
          'Loan Schedule Report',
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
    final path = '${directory.path}/Loan_Schedule_${DateTime.now()}.pdf';

    File(path).writeAsBytes(bytes).then((_) {
      // Open the file using platform agnostic API
      OpenFile.open(path);
    });
  }

  @override
  void initState() {
    super.initState();
    loanScheduleDataSource =
        LoanScheduleDataSource(loanTable: widget.loanTable);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Schedule'),
      ),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 40.0,
                  child: MaterialButton(
                    color: AppColors.contentColorOrange,
                    onPressed: () {},
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
            source: loanScheduleDataSource,
            key: _key,
            columnWidthMode: ColumnWidthMode.fill,
            frozenColumnsCount: 1, // Freeze the first column
            footerFrozenColumnsCount: 1, // Freeze the last column
            // add totals to the footer
            tableSummaryRows: [
              GridTableSummaryRow(
                  showSummaryInRow: false,
                  titleColumnSpan: 3,
                  columns: [
                    const GridSummaryColumn(
                        name: 'principal',
                        columnName: 'principal',
                        summaryType: GridSummaryType.sum),
                    const GridSummaryColumn(
                        name: 'interest',
                        columnName: 'interest',
                        summaryType: GridSummaryType.sum),
                    const GridSummaryColumn(
                        name: 'installment',
                        columnName: 'installment',
                        summaryType: GridSummaryType.sum),
                    const GridSummaryColumn(
                        name: 'balance',
                        columnName: 'balance',
                        summaryType: GridSummaryType.sum),
                  ],
                  position: GridTableSummaryRowPosition.bottom),
            ],
            columns: <GridColumn>[
              GridColumn(
                columnName: 'date',
                columnWidthMode: ColumnWidthMode.fitByCellValue,
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Date',
                    style: TextStyle(color: AppColors.contentColorOrange),
                  ),
                ),
              ),
              GridColumn(
                columnName: 'principal',
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Principal',
                    style: TextStyle(color: AppColors.contentColorOrange),
                  ),
                ),
              ),
              GridColumn(
                columnName: 'interest',
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Interest',
                    style: TextStyle(color: AppColors.contentColorOrange),
                  ),
                ),
              ),
              GridColumn(
                columnName: 'installment',
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Installment',
                    style: TextStyle(color: AppColors.contentColorOrange),
                  ),
                ),
              ),
              GridColumn(
                columnName: 'balance',
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Balance',
                    style: TextStyle(color: AppColors.contentColorOrange),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class LoanScheduleDataSource extends DataGridSource {
  LoanScheduleDataSource({required List<LoanSchedule> loanTable}) {
    //initialize the formatter including the deimals and the thousand separator

    _loanData = loanTable
        .map<DataGridRow>((loan) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'date',
                  value: DateFormat('yMd').format(loan.date)),
              DataGridCell<double>(columnName: 'principal', value: loan.base),
              DataGridCell<double>(columnName: 'interest', value: loan.percent),
              DataGridCell<double>(
                  columnName: 'installment', value: loan.installment),
              DataGridCell<double>(columnName: 'balance', value: loan.balance),
            ]))
        .toList();
  }

  List<DataGridRow> _loanData = [];

  @override
  List<DataGridRow> get rows => _loanData;

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    // log the summary value

    //log the summary column name
    return Container(
        padding: const EdgeInsets.all(15.0), child: Text(summaryValue));
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      final formatter = NumberFormat('#,##0.00');

      // if the column is principla, balance , installment or interest. format the value
      if (e.columnName == 'principal' ||
          e.columnName == 'balance' ||
          e.columnName == 'installment' ||
          e.columnName == 'interest') {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(formatter.format(e.value)),
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
