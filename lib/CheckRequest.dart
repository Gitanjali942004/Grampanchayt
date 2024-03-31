import 'package:flutter/material.dart';
import 'package:grampanchayat/RequestForm.dart';
import 'package:grampanchayat/AboutUs.dart';
import 'package:grampanchayat/CheckRequest.dart';
import 'package:grampanchayat/ContactUs.dart';
import 'package:grampanchayat/EditProfile.dart';
import 'package:grampanchayat/RequestForm.dart';
import 'package:grampanchayat/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckRequest(),
      routes: {
       // '/request': (context) => RequestForm(),
        '/checkrequest':(context) => CheckRequest(),
        '/aboutus':(context) => AboutUs(),
        '/contactus':(context) => ContactUs(),
        //'/editprofile':(context) => EditProfile(),

      },
    );
  }
}

class CheckRequest extends StatefulWidget {
  @override
  _CheckRequestState createState() => _CheckRequestState();
}

class _CheckRequestState extends State<CheckRequest> {
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
      body: Text('Check Request '),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "Abhishek Mishra",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("abhishekm977@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(' Home '),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),

            ListTile(
                leading: const Icon(Icons.book),
                title: const Text(' Check Request '),
                onTap: () {
                  Navigator.pushNamed(context, '/checkrequest');
                },
              ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text(' About Us'),
              onTap: () {
                Navigator.pushNamed(context, '/aboutus');

              },
            ),
            ListTile(
              leading: const Icon(Icons.call),
              title: const Text(' Contact Us '),
              onTap: () {
                Navigator.pushNamed(context, '/contactus');
              },
            ),




            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);

              },
            ),
          ],
        ),
      ),
    );
  }
}
