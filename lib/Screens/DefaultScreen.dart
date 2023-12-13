import 'package:valour/Screens/HomePage.dart';
import 'package:valour/Screens/InventoryScreen.dart';
import 'package:valour/Screens/VisitsPage.dart';
import 'package:valour/Screens/sales/index.dart';
import 'package:valour/Utils/AppColors.dart';
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
    const VisitsPage(),
    const Sale(),
    const InventoryScreen(),
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
        selectedItemColor: AppColors.contentColorPurple,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        // keep me this color:Color.fromARGB(255, 169, 230, 216).withOpacity(0.5),
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_rounded), label: 'Visits'),
          BottomNavigationBarItem(
              icon: Icon(Icons.wallet_travel_rounded), label: 'Sales'),
          // admin==true?BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Inventory'):BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Mainteance'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Inventories'),
          // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Mainteance'),
        ],
      ),
      // floatingActionButton: FloatingActionButton(onPressed: (){

      // }),
    );
  }
}
