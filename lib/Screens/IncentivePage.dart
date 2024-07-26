import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vfu/Controllers/services.dart';
import 'package:vfu/Models/Incentive.dart';
import 'package:vfu/Models/User.dart';
import 'package:vfu/Util/ballons.dart';
import 'package:vfu/Utils/AppColors.dart';

import '../Widgets/Drawer/DrawerItems.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;
import 'package:syncfusion_flutter_pdf/src/pdf/implementation/pdf_document/pdf_document.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/// The home page of the application which hosts the datagrid.
class IncentivePage extends StatefulWidget {
  /// Creates the home page.
  const IncentivePage({super.key});

  @override
  _IncentivePageState createState() => _IncentivePageState();
}

class _IncentivePageState extends State<IncentivePage>
    with SingleTickerProviderStateMixin {
  late Future<List<Incentive>> incentives;
  late IncentiveDataSource generalDataSource;
  late IncentiveDataSource individualDataSource;
  late IncentiveDataSource groupDataSource;
  late IncentiveDataSource fastDataSource;
  late TabController _tabController;
  int currentTabIndex = 0;

  final GlobalKey<SfDataGridState> _generalKey = GlobalKey<SfDataGridState>();
  final GlobalKey<SfDataGridState> _individualKey =
      GlobalKey<SfDataGridState>();
  final GlobalKey<SfDataGridState> _groupKey = GlobalKey<SfDataGridState>();
  final GlobalKey<SfDataGridState> _fastKey = GlobalKey<SfDataGridState>();
  late Future<void> userFuture;
  User? user;

  @override
  void initState() {
    super.initState();
    userFuture = getUser();
    incentives = getIncentiveData();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    setState(() {
      currentTabIndex = _tabController.index;
    });
  }

  Future<void> exportDataGridToExcel(GlobalKey<SfDataGridState> key) async {
    final Workbook workbook = key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();

    // Get the temporary directory path
    final directory = await getTemporaryDirectory();
    // generate the file path using the current date and time
    final path = '${directory.path}/Incentive_${DateTime.now()}.xlsx';

    // Write the file
    File(path).writeAsBytes(bytes).then((_) {
      // Open the file using platform agnostic API
      OpenFile.open(path);
    });

    workbook.dispose();
  }

  Future<void> _exportDataGridToPdf(GlobalKey<SfDataGridState> key) async {
    final PdfDocument document =
        key.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true);

    final List<int> bytes = document.saveSync();
    // Get the temporary directory path
    final directory = await getTemporaryDirectory();

    // generate the file path using the current date and time
    final path = '${directory.path}/Incentive_${DateTime.now()}.pdf';

    File(path).writeAsBytes(bytes).then((_) {
      // Open the file using platform agnostic API
      OpenFile.open(path);
    });
  }

  Future<void> getUser() async {
    try {
      AuthController authController = AuthController();
      User response = await authController.getUserDetails();
      log("user details: $response");
      if (response.status == 'success') {
        setState(() {
          user = response;
        });
      } else {
        log("no success in user details: $response");
        setState() {
          user = User(
            name: 'Error',
            username: 'Error',
            staffId: 'Error',
            userType: 'Error',
            regionId: 'Error',
            branchId: 'Error',
            status: 'Error',
          );
        }
      }
    } catch (e) {
      log("user error: $e");
      setState(() {
        user = User(
          name: 'Error',
          username: 'Error',
          staffId: 'Error',
          userType: 'Error',
          regionId: 'Error',
          branchId: 'Error',
          status: 'Error',
        );
      });
    }
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
          "Incentives",
          style: GoogleFonts.lato(
              fontSize: size.width * 0.062,
              color: AppColors.menuBackground,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: user!.userType == '1'
            ? null
            : TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'General'),
                  Tab(text: 'Individual'),
                  Tab(text: 'Group'),
                  Tab(text: 'Fast'),
                ],
              ),
      ),
      body: FutureBuilder(
        future: incentives,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred while loading data'),
            );
          }

          if (user!.userType == '1') {
            //return a beatiful card with incentive data from snapshot
            return BalloonCard(snapshot: snapshot);
          }

          //check if the data is empty
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          }
          final List<Incentive> incentives = snapshot.data as List<Incentive>;

          generalDataSource = IncentiveDataSource(
              incentiveData: incentives,
              currentTabIndex: currentTabIndex); // General data source
          individualDataSource = IncentiveDataSource(
              incentiveData: incentives,
              currentTabIndex:
                  currentTabIndex); // Individual data source (customize)
          groupDataSource = IncentiveDataSource(
              incentiveData: incentives,
              currentTabIndex:
                  currentTabIndex); // Group data source (customize)
          fastDataSource = IncentiveDataSource(
              incentiveData: incentives,
              currentTabIndex: currentTabIndex); // Fast data source (customize)

          return TabBarView(
            controller: _tabController,
            children: [
              _buildDataGrid(context, generalDataSource, _generalKey,
                  currentTabIndex), // General Tab
              _buildDataGrid(context, individualDataSource, _individualKey,
                  currentTabIndex), // Individual Tab
              _buildDataGrid(context, groupDataSource, _groupKey,
                  currentTabIndex), // Group Tab
              _buildDataGrid(context, fastDataSource, _fastKey,
                  currentTabIndex), // Fast Tab
            ],
          );
        },
      ),
    );
  }

  Widget _buildDataGrid(BuildContext context, IncentiveDataSource dataSource,
      GlobalKey<SfDataGridState> key, int currentTabIndex) {
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
                      exportDataGridToExcel(key);
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
                    onPressed: () {
                      exportDataGridToExcel(key);
                    },
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
            key: key,
            source: dataSource,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            frozenColumnsCount: 1, // Number of columns to freeze
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
                      child: const Text('Full Name'))),
              if (currentTabIndex == 1 || currentTabIndex == 0)
                GridColumn(
                    columnName: 'outstandingPrincipalIndividual',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child:
                            const Text('Outstanding Principal(Individual)'))),
              if (currentTabIndex == 2 || currentTabIndex == 0)
                GridColumn(
                    columnName: 'outstandingPrincipalGroup',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Outstanding Principal(Group)'))),
              if (currentTabIndex == 3)
                GridColumn(
                    columnName: 'outstandingPrincipalSGL',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Outstanding Principal(SGL)'))),
              if (currentTabIndex == 1 || currentTabIndex == 0)
                GridColumn(
                    columnName: 'noOfCustomersIndividual',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('No of Customers(Individual)'))),
              if (currentTabIndex == 2 || currentTabIndex == 0)
                GridColumn(
                    columnName: 'noOfCustomersGroup',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('No of Customers(Group)'))),
              GridColumn(
                  columnName: 'par1Day',
                  columnWidthMode: ColumnWidthMode.fitByColumnName,
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('PAR>1 Day(%)'))),
              GridColumn(
                  columnName: 'llr',
                  columnWidthMode: ColumnWidthMode.fitByColumnName,
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('llr'))),
              if (currentTabIndex == 3 || currentTabIndex == 0)
                GridColumn(
                    columnName: 'sgl',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('sgl'))),
              GridColumn(
                  columnName: 'incentivePar1Day',
                  columnWidthMode: ColumnWidthMode.fitByColumnName,
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Incentive(PAR>1 Day)'))),
              GridColumn(
                  columnName: 'incentiveNetPortifolioGrowth',
                  columnWidthMode: ColumnWidthMode.fitByColumnName,
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Incentive(Net Portifolio Growth)'))),
              GridColumn(
                  columnName: 'incentiveNetClientGrowth',
                  columnWidthMode: ColumnWidthMode.fitByColumnName,
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Incentive(Net Client Growth)'))),
              if (currentTabIndex == 3)
                GridColumn(
                    columnName: 'incentiveNoOfSglGroups',
                    columnWidthMode: ColumnWidthMode.fitByColumnName,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Incentive(No Of SGL Groups)'))),
              GridColumn(
                  columnName: 'totalIncentive',
                  columnWidthMode: ColumnWidthMode.fitByColumnName,
                  label: Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text('Total Incentive'))),
            ],
          ),
        ),
      ],
    );
  }

  Future<List<Incentive>> getIncentiveData() async {
    try {
      AuthController authController = AuthController();

      final response = await authController.getIncentives();

      List<Incentive> incentives = [];

      response.forEach((key, value) {
        try {
          incentives.add(Incentive.fromJson(value));
        } catch (e) {
          log("Error parsing incentive data for key $key: $e");
        }
      });

      return incentives;
    } catch (e) {
      log("Fetching incentive Error: $e");
      return [];
    }
  }
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class IncentiveDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  IncentiveDataSource(
      {required List<Incentive> incentiveData, required int currentTabIndex}) {
    List<Incentive> filteredData;
    if (currentTabIndex == 0) {
      _incentiveData = incentiveData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'OfficerId', value: e.OfficerId),
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell<String>(
                    columnName: 'outstandingPrincipalIndividual',
                    value: e.outstandingPrincipalIndividual),
                DataGridCell<String>(
                    columnName: 'outstandingPrincipalGroup',
                    value: e.outstandingPrincipalGroup),
                DataGridCell<String>(
                    columnName: 'noOfCustomersIndividual',
                    value: e.noOfCustomersIndividual),
                DataGridCell<String>(
                    columnName: 'noOfCustomersGroup',
                    value: e.noOfCustomersGroup),
                DataGridCell<String>(columnName: 'par1Day', value: e.par1Day),
                DataGridCell<String>(columnName: 'llr', value: e.llr),
                DataGridCell<String>(columnName: 'sgl', value: e.sgl),
                DataGridCell<String>(
                    columnName: 'incentivePar1Day', value: e.incentivePar1Day),
                DataGridCell<String>(
                    columnName: 'incentiveNetPortifolioGrowth',
                    value: e.incentiveNetPortifolioGrowth),
                DataGridCell<String>(
                    columnName: 'incentiveNetClientGrowth',
                    value: e.incentiveNetClientGrowth),
                DataGridCell<String>(
                    columnName: 'totalIncentive', value: e.totalIncentive),
              ]))
          .toList();
    }

    if (currentTabIndex == 1) {
      filteredData =
          incentiveData.where((e) => e.incentiveType == 'individual').toList();
      _incentiveData = filteredData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'OfficerId', value: e.OfficerId),
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell<String>(
                    columnName: 'outstandingPrincipalIndividual',
                    value: e.outstandingPrincipalIndividual),
                DataGridCell<String>(
                    columnName: 'noOfCustomersIndividual',
                    value: e.noOfCustomersIndividual),
                DataGridCell<String>(columnName: 'par1Day', value: e.par1Day),
                DataGridCell<String>(columnName: 'llr', value: e.llr),
                DataGridCell<String>(
                    columnName: 'incentivePar1Day', value: e.incentivePar1Day),
                DataGridCell<String>(
                    columnName: 'incentiveNetPortifolioGrowth',
                    value: e.incentiveNetPortifolioGrowth),
                DataGridCell<String>(
                    columnName: 'incentiveNetClientGrowth',
                    value: e.incentiveNetClientGrowth),
                DataGridCell<String>(
                    columnName: 'totalIncentive', value: e.totalIncentive),
              ]))
          .toList();
    }

    if (currentTabIndex == 2) {
      // Group
      filteredData =
          incentiveData.where((e) => e.incentiveType == 'group').toList();
      _incentiveData = incentiveData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'OfficerId', value: e.OfficerId),
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell<String>(
                    columnName: 'outstandingPrincipalGroup',
                    value: e.outstandingPrincipalGroup),
                DataGridCell<String>(
                    columnName: 'noOfCustomersGroup',
                    value: e.noOfCustomersGroup),
                DataGridCell<String>(columnName: 'par1Day', value: e.par1Day),
                DataGridCell<String>(columnName: 'llr', value: e.llr),
                DataGridCell<String>(
                    columnName: 'incentivePar1Day', value: e.incentivePar1Day),
                DataGridCell<String>(
                    columnName: 'incentiveNetPortifolioGrowth',
                    value: e.incentiveNetPortifolioGrowth),
                DataGridCell<String>(
                    columnName: 'incentiveNetClientGrowth',
                    value: e.incentiveNetClientGrowth),
                DataGridCell<String>(
                    columnName: 'totalIncentive', value: e.totalIncentive),
              ]))
          .toList();
    }

    if (currentTabIndex == 3) {
      // Fast
      filteredData =
          incentiveData.where((e) => e.incentiveType == 'fast').toList();
      log("Fast Data: $filteredData");
      _incentiveData = filteredData
          .map<DataGridRow>((e) => DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'OfficerId', value: e.OfficerId),
                DataGridCell<String>(columnName: 'name', value: e.name),
                DataGridCell<String>(
                    columnName: 'outstandingPrincipalSGL',
                    value: e.outstandingPrincipalSgl),
                DataGridCell<String>(columnName: 'par1Day', value: e.par1Day),
                DataGridCell<String>(columnName: 'llr', value: e.llr),
                DataGridCell<String>(columnName: 'sgl', value: e.sgl),
                DataGridCell<String>(
                    columnName: 'incentivePar1Day', value: e.incentivePar1Day),
                DataGridCell<String>(
                    columnName: 'incentiveNetPortifolioGrowth',
                    value: e.incentiveNetPortifolioGrowth),
                DataGridCell<String>(
                    columnName: 'incentiveNetClientGrowth',
                    value: e.incentiveNetClientGrowth),
                DataGridCell<String>(
                    columnName: 'incentiveNoOfSglGroups',
                    value: e.incentiveNetClientGrowth),
                DataGridCell<String>(
                    columnName: 'totalIncentive', value: e.totalIncentive),
              ]))
          .toList();
    }
  }

  List<DataGridRow> _incentiveData = [];

  @override
  List<DataGridRow> get rows => _incentiveData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final formatter = NumberFormat('#,###'); //formatter for number format
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if ([
        'totalIncentive',
        'incentiveNetClientGrowth',
        'incentiveNetPortifolioGrowth',
        'incentivePar1Day',
        'sgl',
        'noOfCustomersGroup',
        'noOfCustomersIndividual',
        'outstandingPrincipalGroup',
        'outstandingPrincipalIndividual',
        'outstandingPrincipalSGL'
      ].contains(e.columnName)) {
        if (e.value == 'null') {
          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text('0'));
        }
        return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(formatter.format(double.parse(e.value.toString())))
            // or any default value you prefer
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
