import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerItems extends StatefulWidget {
  const DrawerItems({super.key});

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
  return Drawer(
  width: size.width * 0.8,
  child: Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue, // Adjust the background color of the drawer header
          ), child: null,
          // ... other header content ...
        ),
        ListTile(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.red, // Change the color of the drawer icon here
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          title: Text('Menu'),
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        // ... other drawer items ...
      ],
    ),
  ),
);

  }
}