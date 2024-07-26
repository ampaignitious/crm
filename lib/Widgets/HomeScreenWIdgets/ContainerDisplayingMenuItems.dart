import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vfu/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vfu/Controllers/services.dart';

import '../../Models/ChartDataModal.dart';

class ContainerDisplayingMenuItems extends StatefulWidget {
  const ContainerDisplayingMenuItems({super.key});

  @override
  State<ContainerDisplayingMenuItems> createState() =>
      _ContainerDisplayingMenuItemsState();
}

class _ContainerDisplayingMenuItemsState
    extends State<ContainerDisplayingMenuItems> {
  late Future<Map<String, dynamic>> dashboardData;
  @override
  void initState() {
    super.initState();
    dashboardData = getDashboardData();
  }

  Future<Map<String, dynamic>> getDashboardData() async {
    try {
      AuthController authController = AuthController();

      final response = await authController.getDashboard();
      print("Dashboard data: $response['data']");
      final arrearsData = response['data'];
      print("Arrears data: $arrearsData");
      return arrearsData;
    } catch (e) {
      log("An error occurred while fetching dashboard data: $e");
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: dashboardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("An error occurred"),
            );
          }

          //check if the snapshot has data
          if (!snapshot.hasData) {
            return const Center(
              child: Text("No data available"),
            );
          }

          //get the data
          final dashboard = snapshot.data;
          //outstanding principal percentage of the sum of outstanding principal and principal in arrears
          double outstandingPrincipalPercentage =
              (double.parse(dashboard?['outstanding_principal']) /
                      (double.parse(dashboard?['outstanding_principal']) +
                          double.parse(dashboard?['principal_arrears']))) *
                  100;
          //principal in arrears percentage of the sum of outstanding principal and principal in arrears
          double principalInArrearsPercentage =
              (double.parse(dashboard?['principal_arrears']) /
                      (double.parse(dashboard?['outstanding_principal']) +
                          double.parse(dashboard?['principal_arrears']))) *
                  100;
          final List<ChartData> chartData = [
            ChartData(
              'Outstanding Principal',
              double.parse(outstandingPrincipalPercentage.toStringAsFixed(2)),
            ),
            ChartData(
              'Principal In Arrears',
              double.parse(principalInArrearsPercentage.toStringAsFixed(2)),
            ),
          ];
          final formatter =
              NumberFormat('#,###'); // Create NumberFormat instance

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // first row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCard("Outstanding Principal",
                        "${formatter.format(int.parse(dashboard?['outstanding_principal']))}/="),
                    //
                    // first row element two
                    buildCard("New Loans",
                        "${formatter.format(int.parse(dashboard?['total_disbursements']))}/="),
                  ],
                ),
              ),
              //
              SizedBox(
                height: size.height * 0.02,
              ),
              // Second row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCard("Principal In Arrears",
                        "${formatter.format(int.parse(dashboard?['principal_arrears']))}/="),
                    //
                    // second row element two
                    buildCard(
                        "Number Of Women",
                        formatter.format(int.parse(
                            dashboard!['number_of_female_borrowers']))),
                  ],
                ),
              ),
              //
              SizedBox(
                height: size.height * 0.02,
              ),
              // third row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCard(
                        "Number Of Children",
                        formatter.format(
                            int.parse(dashboard['number_of_children']))),
                    //
                    // Third row element two
                    buildCard(
                        "Number Of Clients",
                        formatter
                            .format(int.parse(dashboard['number_of_clients']))),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCard(
                        "Solidarity Groups",
                        formatter
                            .format(int.parse(dashboard['number_of_groups']))),
                    //
                    // Third row element two
                    buildCard(
                        "Solidarity Members",
                        formatter.format(
                            int.parse(dashboard['number_of_individuals']))),
                    //
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCard(
                        "SGL", formatter.format(int.parse(dashboard['sgl']))),
                    //
                    // Third row element two
                    buildCard("PAR>1Day", dashboard['par_1_days'] + "%"),
                    //
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //
                    // Third row element two
                    buildCard("PAR>30Days", dashboard['par_30_days'] + "%"),
                    //
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),

              // Pie chart
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Container(
                  height: size.height * 0.6,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.contentColorOrange.withOpacity(0.5)),
                  ),
                  child: buildPieChart(chartData),
                ),
              ),

              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          );
        });
  }

  Widget buildCard(String title, String value) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      width: size.width * 0.45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: AppColors.contentColorOrange.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(0.8, 1.0),
            blurRadius: 4.0,
            spreadRadius: 0.2,
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(-0.8, -1.0),
            blurRadius: 4.0,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: size.width * 0.04,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.lato(
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  // build pie chart
  Widget buildPieChart(List<ChartData> chartData) {
    return SfCircularChart(
      title: ChartTitle(text: 'Outstanding Principal and Principal In Arrears'),
      legend: Legend(isVisible: true),
      series: <PieSeries<ChartData, String>>[
        PieSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          radius: "100%",
          pointColorMapper: (ChartData data, _) =>
              data.category == 'Outstanding Principal'
                  ? Colors.green
                  : Colors.red,
        )
      ],
    );
  }
}
