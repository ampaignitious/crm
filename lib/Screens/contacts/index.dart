import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valour/Controllers/services.dart';
import 'package:valour/Models/Contact.dart';
import 'package:valour/Screens/contacts/ContactDetail.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:valour/Widgets/Drawer/DrawerItems.dart';
import 'package:valour/Widgets/VisitScreenWidgets/BusinessMappingForm.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  ContactsState createState() => ContactsState();
}

class ContactsState extends State<Contacts> {
  late Future<List<Contact>> allContacts;

  List<Contact> displayedContacts = [];

  @override
  void initState() {
    super.initState();
    allContacts = loadContacts();
    filterContacts('');
  }

  Future<List<Contact>> loadContacts() async {
    AuthController authController = AuthController();
    try {
      final response = await authController.getContacts();
      if (response.containsKey("error")) {
        throw Exception("The return is an error");
      } else {
        if (response['contacts'] != null) {
          List<dynamic> contactsData = response['contacts'];
          List<Contact> contacts = contactsData.map((contactData) {
            return Contact(
              id: contactData['business_id'],
              businessName: contactData['business_name'],
              contactNumber: contactData['business_telephone_contact'],
              email: contactData['business_email_contact'],
            );
          }).toList();

          return contacts;
        } else {
          // Handle the case where the 'contacts' field in the API response is null
          print("'contacts' field in API response is null");
          throw Exception("'contacts' field in API response is null");
        }
      }
    } catch (error) {
      // Handle the case where the 'contacts' field in the API response is null
      print("'contacts' field in API response is null");
      throw Exception("'contacts' field in API response is null");
    }
  }

  Future<void> filterContacts(String query) async {
    List<Contact> allContacts = await loadContacts();
    setState(() {
      displayedContacts.clear();
      if (query.isEmpty) {
        displayedContacts.addAll(allContacts);
      } else {
        List<String> searchTerms = query.toLowerCase().split(' ');
        displayedContacts.addAll(allContacts.where((contact) {
          String fullName = contact.businessName.toLowerCase();

          // Check if any part of the full name matches any search term
          bool fullNameMatch =
              searchTerms.every((term) => fullName.contains(term));

          // Check if any part of the first name or last name matches any search term
          bool firstNameMatch = searchTerms.every(
              (term) => contact.businessName.toLowerCase().contains(term));
          bool lastNameMatch = searchTerms.every(
              (term) => contact.businessName.toLowerCase().contains(term));

          // Check if the institution name contains any search term
          bool institutionNameMatch = searchTerms
              .every((term) => contact.email.toLowerCase().contains(term));

          return fullNameMatch ||
              firstNameMatch ||
              lastNameMatch ||
              institutionNameMatch;
        }));
      }
      displayedContacts
          .sort((a, b) => '${a.businessName}}'.compareTo('${b.businessName}}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.contentColorPurple,
        width: size.width * 0.8,
        child: const DrawerItems(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.contentColorPurple,
          size: size.width * 0.11,
        ),
        backgroundColor: AppColors.contentColorCyan,
        title: Text(
          "Contacts",
          style: GoogleFonts.lato(
              fontSize: size.width * 0.05,
              color: AppColors.menuBackground,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const BusinessMappingForm();
              }));
            },
            icon: const Icon(Icons.add),
            color: AppColors.contentColorPurple,
            iconSize: size.width * 0.08,
          ),
        ],
      ),
      body: FutureBuilder(
          future: allContacts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If the Future throws an error, display an error message
              return Text('Error loading contacts: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // If the Future completes successfully but with no data, display a message
              return const Text('No contacts available.');
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search contacts...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          filterContacts(value);
                        }),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: displayedContacts.length,
                      itemBuilder: (context, index) {
                        Contact contact = displayedContacts[index];

                        return ListTile(
                          leading: const Icon(Icons.person), // Person icon
                          title: Text(contact.businessName),
                          subtitle: Text(contact.email),
                          onTap: () =>  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ContactCard(contact: contact),
                                    ),
                                  ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.phone), // Phone icon
                                onPressed: () {
                                  FlutterPhoneDirectCaller.callNumber(
                                      contact.contactNumber);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
