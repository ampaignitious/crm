import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vfu/Controllers/services.dart';
import 'package:vfu/Screens/AllPage.dart';
import 'package:vfu/Screens/ApplicationPage.dart';
import 'package:vfu/Screens/AppraisalPage.dart';
import 'package:vfu/Screens/MarketingPage.dart';
import 'package:vfu/Utils/AppColors.dart';
import 'package:vfu/Widgets/Drawer/DrawerItems.dart';

class SalesActivityPage extends StatefulWidget {
  const SalesActivityPage({Key? key}) : super(key: key);

  @override
  State<SalesActivityPage> createState() => _SalesActivityPageState();
}

class _SalesActivityPageState extends State<SalesActivityPage> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    const AllPage(),
    const MarketingPage(),
    const AppraisalPage(),
    const ApplicationPage(),
  ];
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<bool> addMonitor(
      String name, String phone, String location, String activity) async {
    AuthController authController = AuthController();
    bool response =
        await authController.createMonitor(name, phone, location, activity);

    return response;
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
        iconTheme: const IconThemeData(
          color: AppColors.contentColorOrange,
        ), // Change the icon color here
        backgroundColor: AppColors.contentColorCyan,
        actions: [
          // Add button here
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showModalSheet,
          ),
        ],
        title: Text(
          "Sales Activity",
          style: GoogleFonts.lato(
            fontSize: size.width * 0.062,
            color: AppColors.menuBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    DateFormat('MMM d, yyyy').format(_selectedDate),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: pages[_selectedIndex]),
        ],
      ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.satellite),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_rounded),
            label: 'Marketing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_travel_rounded),
            label: 'Appraisal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Application',
          ),
        ],
      ),
    );
  }

void _showModalSheet() {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String activity = 'Marketing';
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (builder) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              color: Colors.transparent,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Add this line
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Add Sales Activity',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          hintText: 'Phone',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          hintText: 'Location',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity, // Set width to cover entire width
                      child: DropdownButton<String>(
                        value: activity,
                        items: const [
                          DropdownMenuItem(
                            child: Text('Marketing'),
                            value: 'Marketing',
                          ),
                          DropdownMenuItem(
                            child: Text('Appraisal'),
                            value: 'Appraisal',
                          ),
                          DropdownMenuItem(
                            child: Text('Application'),
                            value: 'Application',
                          ),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            activity = value!;
                          });
                        },
                        hint: const Text('Activity'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String name = nameController.text;
                        String phone = phoneController.text;
                        String location = locationController.text;

                        if (name.isNotEmpty &&
                            phone.isNotEmpty &&
                            location.isNotEmpty) {
                          bool response =
                              await addMonitor(name, phone, location, activity);
                          if (response) {
                            // Show a message or handle the response
                            // For example:
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('New Activity added successfully.'),
                              ),
                            );

                            Navigator.pop(context); // Close modal after adding
                            //set the current index
                            Get.offAllNamed('/sales-activity');
                          } else {
                            // Show a message or handle the response
                            // For example:
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to add Activity.'),
                              ),
                            );
                          }
                        } else {
                          // Show a message or handle the empty fields
                          // For example:
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fill in all fields.'),
                            ),
                          );
                        }
                      },
                      child: const Text('Add'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

}
