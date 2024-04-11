import 'package:flutter/material.dart';
import 'package:grampanchayat/RequestForm.dart';
import 'package:grampanchayat/AboutUs.dart';
import 'package:grampanchayat/CheckRequest.dart';
import 'package:grampanchayat/ContactUs.dart';
import 'package:grampanchayat/EditProfile.dart';
import 'package:grampanchayat/RequestForm.dart';
import 'package:grampanchayat/main.dart';

import 'MyDrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String selectedRole = 'ग्रामस्थ';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactUs(selectedRole: selectedRole),
      routes: {

        '/request': (context) => RequestForm(selectedRole: selectedRole),
        '/checkrequest':(context) => CheckRequest(selectedRole: selectedRole),
        '/aboutus':(context) => AboutUs(selectedRole: selectedRole),
        '/contactus':(context) => ContactUs(selectedRole: selectedRole),
        '/editprofile':(context) => EditProfile(selectedRole: selectedRole),

      },
    );
  }
}

class ContactUs extends StatefulWidget {
  final String selectedRole;

  const ContactUs({Key? key, required this.selectedRole}) : super(key: key);
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFA5D7E8),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Grampanchayat App"),
        leading: IconButton(
          icon: Icon(Icons.menu), // Hamburger icon
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the Drawer
          },
        ),
      ),
      body: Text('About Us '),
      drawer: MyDrawer(
        selectedRole: widget.selectedRole,
        onNavigation: (route) {
          Navigator.pushNamed(context, route); // Navigate to selected route
        },
      ),
    );
  }
}
