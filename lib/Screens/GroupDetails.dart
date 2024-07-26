import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:vfu/Utils/AppColors.dart';

class GroupDetailsPage extends StatefulWidget {
  const GroupDetailsPage({super.key});

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _customerData = [];
  bool _isCustomerFound = false;
  String _selectedSearchOption = 'customer_id'; // Default value
  final Map<String, String> _searchOptions = {
    'Customer ID': 'customer_id',
    'Phone': 'phone',
    'Group ID': 'group_id',
    'Group Name': 'group_name'
  };

  Future<void> _searchCustomer() async {
    final response = await http.post(
      Uri.parse(
          'https://vfuarrearsandtracker.impact-outsourcing.com/api/group-details'),
      body: jsonEncode({
        'customer_id': _searchController.text,
        'search_by': _selectedSearchOption
      }),
      headers: {'Content-Type': 'application/json'},
    );

    log(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse is List) {
        setState(() {
          _customerData = jsonResponse;
          _isCustomerFound = true;
        });
      } else {
        setState(() {
          _isCustomerFound = false;
        });
      }
    } else {
      setState(() {
        _isCustomerFound = false;
      });
    }
  }

  num _parseNumber(dynamic value) {
    if (value is String) {
      return num.tryParse(value) ?? 0;
    } else if (value is num) {
      return value;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Details",
            style: GoogleFonts.lato(
                fontSize: size.width * 0.062, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.contentColorCyan,
        iconTheme: IconThemeData(
            color: AppColors.contentColorOrange, size: size.width * 0.11),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Search Option:'),
                  const SizedBox(width: 10), // Consistent spacing using const
                  Expanded(
                    flex: 1,
                    child: DropdownButton<String>(
                      value: _selectedSearchOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSearchOption = newValue!;
                        });
                      },
                      items: _searchOptions.entries
                          .map<DropdownMenuItem<String>>((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.value,
                          child: Text(entry.key),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 10), // Consistent spacing using const
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Enter Customer ID e.g 123456',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Consistent spacing using const
                  ElevatedButton(
                    onPressed: _searchCustomer,
                    child: const Text('Search'), // Consistent use of const
                  ),
                ],
              ),
              SizedBox(height: 20),
              _isCustomerFound
                  ? Column(
                    children: [
                      // 5 results found on search by ...
                      Text(
                        '${_customerData.length} result(s) found on search by ${_selectedSearchOption}',
                        style: TextStyle(fontSize: 18),
                      ),
                      
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _customerData.length,
                          itemBuilder: (context, index) {
                            final customer = _customerData[index];
                            return Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.orange,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Customer Details',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage:
                                              AssetImage('assets/img/avatar.png'),
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Customer Name:${customer['names']}',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              'Customer ID: ${customer['customer_id']}',
                                            ),
                                            Text(
                                              'Phone: ${customer['phone']}',
                                            ),
                                            Text(
                                              'Group ID: ${customer['group_id']}',
                                            ),
                                            Text(
                                              'Group Name: ${customer['group_name']}',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  )
                  : Text('Not Found'),
            ],
          ),
        ),
      ),
    );
  }
}
