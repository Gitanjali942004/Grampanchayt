import 'package:flutter/material.dart';
import 'package:grampanchayat/RequestForm.dart';
import 'package:grampanchayat/MyDrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String selectedRole = 'ग्रामस्थ'; // Define selectedRole here

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EditProfile(selectedRole: selectedRole),
    );
  }
}

class EditProfile extends StatelessWidget {
  final String selectedRole;

  const EditProfile({Key? key, required this.selectedRole}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA5D7E8),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Grampanchayat App"),
        leading: Builder( // Wrap with Builder
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the Drawer
            },
          ),
        ),
      ),
      body: Center(
        child: Text('Edit Profile'),
      ),
      drawer: MyDrawer(
        selectedRole: selectedRole,
        onNavigation: (route) {
          Navigator.pushNamed(context, route); // Navigate to selected route
        },
      ),
    );
  }
}
