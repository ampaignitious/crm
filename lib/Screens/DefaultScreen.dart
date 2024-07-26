import 'package:vfu/Screens/ArrearPage.dart';
import 'package:vfu/Screens/CalculatorPage.dart';
import 'package:vfu/Screens/HomePage.dart';
import 'package:vfu/Screens/SalesTrackerPage.dart';
import 'package:vfu/Utils/AppColors.dart';
import 'package:flutter/material.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  int _selectedIndex = 0;
  List Page = [
    const HomePage(),
    const ArrearPage(),
    const CalculatorPage(),
    const SalesTrackerPage(),
//  MainteanceScreen(),
  ];
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // bool admin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.contentColorCyan,
        currentIndex: _selectedIndex,
        onTap: ((value) => onItemTapped(value)),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.contentColorOrange,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        // keep me this color:Color.fromARGB(255, 169, 230, 216).withOpacity(0.5),
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_rounded), label: 'Arrears'),
          BottomNavigationBarItem(
              icon: Icon(Icons.wallet_travel_rounded), label: 'Calculator'),
          // admin==true?BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Inventory'):BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Mainteance'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Tracker'),
          // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Mainteance'),
        ],
      ),
      // floatingActionButton: FloatingActionButton(onPressed: (){

      // }),
    );
  }
}
