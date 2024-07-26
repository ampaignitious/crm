import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vfu/Controllers/services.dart';
import 'package:vfu/Models/AllComment.dart';
import 'package:vfu/Utils/AppColors.dart';

import '../Widgets/Drawer/DrawerItems.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/pdf_document/pdf_document.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
/// The home page of the application which hosts the datagrid.
class CommentsPage extends StatefulWidget {
  /// Creates the home page.
  const CommentsPage({super.key});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late Future<List<AllComment>> comments;
  late AllCommentDataSource commentDataSource;

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  @override
  void initState() {
    super.initState();
    comments = getCommentsData();
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
          "All Comments",
          style: GoogleFonts.lato(
              fontSize: size.width * 0.062,
              color: AppColors.menuBackground,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: comments,
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

            commentDataSource =
                AllCommentDataSource(commentData: snapshot.data!);

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
                    source: commentDataSource,
                    columnWidthMode: ColumnWidthMode.fitByCellValue,
                    frozenColumnsCount: 1, // Number of columns to freeze
                    frozenRowsCount: 1, // Number of rows to freeze
                    key: _key,
                    //apply pagination
                    allowSorting: true,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'commentId',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                '#',
                              ))),
                      GridColumn(
                          columnName: 'customerId',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Customer ID'))),
                      GridColumn(
                          columnName: 'name',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text(
                                'Names',
                                overflow: TextOverflow.ellipsis,
                              ))),
                      GridColumn(
                          columnName: 'comment',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Comments'))),
                      GridColumn(
                          columnName: 'numberOfDaysLate',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Number Of Days Late'))),
                      GridColumn(
                          columnName: 'createdAt',
                          columnWidthMode: ColumnWidthMode.auto,
                          label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Date Posted'))),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Future<List<AllComment>> getCommentsData() async {
    try {
      AuthController authController = AuthController();

      final response = await authController.getAllComments();
      final commentsData = response['comments'] as List;
      final comments = commentsData.map((data) {
        try {
          return AllComment.fromJson(data);
        } catch (e) {
          log("Error parsing comment data: $e");
          // Consider returning a placeholder object or handling differently
          return AllComment(
            1,
            "0",
            "0",
            "0",
            "0",
            "0",
          );
        }
      }).toList();
      return comments;
    } catch (e) {
      return [];
    }
  }
}

/// An object to set the comment collection data source to the datagrid. This
/// is used to map the comment data to the datagrid widget.
class AllCommentDataSource extends DataGridSource {
  /// Creates the comment data source class with required details.
  AllCommentDataSource({required List<AllComment> commentData}) {
    _commentData = commentData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'commentId', value: e.id.toString()),
              DataGridCell<String>(
                  columnName: 'customerId', value: e.customerId),
              DataGridCell<String>(columnName: 'name', value: e.customerName),
              DataGridCell<String>(columnName: 'comment', value: e.comment),
              DataGridCell<String>(
                  columnName: 'numberOfDaysLate', value: e.numberOfDaysLate),
              DataGridCell<String>(columnName: 'createdAt', value: e.formattedDate),
            ]))
        .toList();
  }

  List<DataGridRow> _commentData = [];

  @override
  List<DataGridRow> get rows => _commentData;

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
