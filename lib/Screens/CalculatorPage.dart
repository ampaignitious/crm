import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vfu/Models/LoanSchedule.dart';
import 'package:vfu/Util/DayInputFormatter.dart';
import 'package:vfu/Util/MonthInputFormatter.dart';
import 'package:vfu/Util/ThousandsSeparatorInputFormatter.dart';
import 'package:vfu/Utils/AppColors.dart';
import 'LoanSchedulePage.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Loan detail controllers
  final TextEditingController loanAmount = TextEditingController();
  final TextEditingController annualInterest = TextEditingController();
  final TextEditingController duration = TextEditingController();
  final TextEditingController gracePeriod = TextEditingController();
  final TextEditingController startMonth = TextEditingController();
  final TextEditingController startDay = TextEditingController();
  final TextEditingController startYear = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Loan Calculator",
            style: GoogleFonts.lato(
                fontSize: size.width * 0.062, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.contentColorCyan,
        iconTheme: IconThemeData(
            color: AppColors.contentColorOrange, size: size.width * 0.11),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  // Loan amount
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: TextFormField(
                      controller: loanAmount,
                      keyboardType: TextInputType.number,
                      inputFormatters: [ThousandsSeparatorInputFormatter()],
                      decoration: InputDecoration(
                        labelText: "Loan Amount (UGX)",
                        hintText: "e.g. 3,800",
                        suffixText: "UGX",
                        labelStyle: const TextStyle(
                            color: AppColors.contentColorOrange),
                        floatingLabelStyle: const TextStyle(
                            color: AppColors.contentColorOrange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: AppColors.contentColorOrange),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: AppColors.contentColorOrange, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: AppColors.contentColorOrange, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  // Annual interest
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: TextFormField(
                      controller: annualInterest,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Annual Interest (%)",
                        hintText: "e.g 32",
                        suffixText: "%",
                        labelStyle: const TextStyle(
                            color: AppColors.contentColorOrange),
                        floatingLabelStyle: const TextStyle(
                            color: AppColors.contentColorOrange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: AppColors.contentColorOrange),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: AppColors.contentColorOrange, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: AppColors.contentColorOrange, width: 1.0),
                        ),
                      ),
                    ),
                  ),

                  // Duration
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: TextFormField(
                      controller: duration,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Duration (Months)",
                        hintText: "e.g. 48",
                        suffixText: "Months",
                        labelStyle: const TextStyle(
                            color: AppColors.contentColorOrange),
                        floatingLabelStyle: const TextStyle(
                            color: AppColors.contentColorOrange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: AppColors.contentColorOrange),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: AppColors.contentColorOrange, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: AppColors.contentColorOrange, width: 1.0),
                        ),
                      ),
                    ),
                  ),

                  // Grace period
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: TextFormField(
                      controller: gracePeriod,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Grace Period (Months)",
                        hintText: "e.g. 0",
                        suffixText: "Months",
                        labelStyle: GoogleFonts.lato(
                            fontSize: size.width * 0.05,
                            color: AppColors.contentColorOrange,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.05)),
                      ),
                    ),
                  ),

                  // Start date
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: Row(
                      children: [
                        // Start month
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Month",
                                style: GoogleFonts.lato(
                                    fontSize: size.width * 0.05,
                                    color: AppColors.contentColorOrange,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextFormField(
                                controller: startMonth,
                                keyboardType: TextInputType.number,
                                inputFormatters: [MonthInputFormatter()],
                                decoration: InputDecoration(
                                  hintText: "e.g. 12",
                                  labelStyle: const TextStyle(
                                      color: AppColors.contentColorOrange),
                                  floatingLabelStyle: const TextStyle(
                                      color: AppColors.contentColorOrange),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.05),
                                    borderSide: const BorderSide(
                                        color: AppColors.contentColorOrange),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: AppColors.contentColorOrange,
                                        width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        color: AppColors.contentColorOrange,
                                        width: 1.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Start day
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Day",
                                style: GoogleFonts.lato(
                                    fontSize: size.width * 0.05,
                                    color: AppColors.contentColorOrange,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextFormField(
                                controller: startDay,
                                inputFormatters: [DayInputFormatter()],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "e.g. 28",
                                    labelStyle: const TextStyle(
                                        color: AppColors.contentColorOrange),
                                    floatingLabelStyle: const TextStyle(
                                        color: AppColors.contentColorOrange),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.05),
                                      borderSide: const BorderSide(
                                          color: AppColors.contentColorOrange),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: AppColors.contentColorOrange,
                                          width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: AppColors.contentColorOrange,
                                          width: 1.0),
                                    )),
                              ),
                            ],
                          ),
                        ),

                        // Start year
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Year",
                                style: GoogleFonts.lato(
                                    fontSize: size.width * 0.05,
                                    color: AppColors.contentColorOrange,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextFormField(
                                controller: startYear,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "e.g. 2024",
                                    labelStyle: const TextStyle(
                                        color: AppColors.contentColorOrange),
                                    floatingLabelStyle: const TextStyle(
                                        color: AppColors.contentColorOrange),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.05),
                                      borderSide: const BorderSide(
                                          color: AppColors.contentColorOrange),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: AppColors.contentColorOrange,
                                          width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: AppColors.contentColorOrange,
                                          width: 1.0),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Calculate button
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: ElevatedButton(
                      onPressed: () {
                        calculate();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.contentColorCyan),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.05)),
                        ),
                      ),
                      child: Text(
                        "Calculate",
                        style: GoogleFonts.lato(
                            fontSize: size.width * 0.05,
                            color: AppColors.contentColorOrange,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculate() {
    // Get input values
    double loanAmountValue = double.parse(loanAmount.text.replaceAll(',', ''));
    double loanInterestValue = double.parse(annualInterest.text);
    double loanDurationValue = double.parse(duration.text);
    double loanGraceValue = double.parse(gracePeriod.text);
    double loanInitMonthValue = double.parse(startMonth.text);
    double loanInitDayValue = double.parse(startDay.text);
    double loanInitYearValue = double.parse(startYear.text);

    // Validate input
    if (loanAmountValue < 1 ||
        loanInterestValue < 0 ||
        loanInterestValue > 100 ||
        loanDurationValue < 1 ||
        loanGraceValue < 0 ||
        loanInitMonthValue < 1 ||
        loanInitMonthValue > 12 ||
        loanInitDayValue < 1 ||
        loanInitDayValue > 31 ||
        loanInitYearValue < 1000 ||
        loanInitYearValue > 9999) {
      // Handle invalid input
      return;
    }

    // Initialize loan start date
    DateTime loanStart = DateTime(loanInitYearValue.toInt(),
        loanInitMonthValue.toInt(), loanInitDayValue.toInt());
    List<LoanSchedule> loanTable = [];

    // Create loan schedule
    for (int i = 0; i < loanDurationValue.toInt(); i++) {
      DateTime d = DateTime(loanStart.year, loanStart.month + i, loanStart.day);

      double p;
      if (i > loanGraceValue) {
        double pmt = PMT(
            (loanInterestValue / 100) / 12,
            loanDurationValue.toInt() - loanGraceValue.toInt(),
            loanAmountValue);
        double ipmt = IPMT(loanAmountValue, pmt, (loanInterestValue / 100) / 12,
            i - loanGraceValue.toInt());
        p = -ipmt;
      } else {
        p = loanAmountValue * (loanInterestValue / 100) / 12;
      }

      double inst;
      if (i >= loanGraceValue) {
        inst = -PMT(
            (loanInterestValue / 100) / 12,
            loanDurationValue.toInt() - loanGraceValue.toInt(),
            loanAmountValue);
      } else {
        inst = p;
      }

      double b = inst - p;
      double c = i == 0 ? loanAmountValue - b : loanTable[i - 1].balance - b;

      // Round off values to 2 decimal places
      p = double.parse(p.toStringAsFixed(2));
      inst = double.parse(inst.toStringAsFixed(2));
      b = double.parse(b.toStringAsFixed(2));
      c = double.parse(c.toStringAsFixed(2));

      loanTable.add(LoanSchedule(
          date: d, base: b, percent: p, installment: inst, balance: c));
    }

    // Navigate to LoanSchedulePage and pass the loanTable
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoanSchedulePage(loanTable: loanTable)),
    );
  }

  double PMT(double rate, int nper, double pv, [double fv = 0, int type = 0]) {
    if (fv == 0) fv = 0;
    if (type == 0) type = 0;
    if (rate == 0) return -(pv + fv) / nper;
    var pvif = pow(1 + rate, nper);
    var pmt = rate / (pvif - 1) * -(pv * pvif + fv);
    if (type == 1) {
      pmt /= (1 + rate);
    }
    return pmt;
  }

  double IPMT(double pv, double pmt, double rate, int per) {
    var tmp = pow(1 + rate, per);
    return 0 - (pv * tmp * rate + pmt * (tmp - 1));
  }
}
