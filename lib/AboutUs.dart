import 'package:flutter/material.dart';
import 'package:grampanchayat/HomePage.dart';
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
  final String aadharNo = '1234567890'; // Example Aadhar number

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AboutUs(selectedRole: selectedRole, aadharNo: aadharNo),
    );
  }
}

class AboutUs extends StatefulWidget {
  final String selectedRole;
  final String aadharNo;

  const AboutUs({Key? key, required this.selectedRole, required this.aadharNo}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ग्रामपंचायत पोतले",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF0B2447),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("AT Post Potale,Patilmala Tal- Karad Dist-Satara"),
                      SizedBox(height: 10),
                      Text(
                        "Phone No:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("02164-1234668"),
                      SizedBox(height: 10),
                      Text(
                        "Email:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("grampanchayatpotale@gmail.com"),
                      SizedBox(height: 10),
                      Text(
                        "Time:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("10AM-6PM"),
                      SizedBox(height: 10),
                      Text(
                        "Weekly Holiday:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Sunday"),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Demographic Data",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Container(
                color: Colors.white,
                constraints: BoxConstraints(maxWidth: 600), // Adjust the width as needed
                child: DataTable(
                  dataRowHeight: 40,
                  headingRowHeight: 40,
                  columnSpacing: 8,
                  columns: [
                    DataColumn(
                      label: Expanded(child: Text('Sr. No', style: TextStyle(fontSize: 14))),
                    ),
                    DataColumn(
                      label: Expanded(child: Text('Category', style: TextStyle(fontSize: 14))),
                    ),
                    DataColumn(
                      label: Expanded(child: Text('Total', style: TextStyle(fontSize: 14))),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Expanded(child: Text('Male', style: TextStyle(fontSize: 14))),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Expanded(child: Text('Female', style: TextStyle(fontSize: 14))),
                      numeric: true,
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Expanded(child: Text('1', style: TextStyle(fontSize: 14)))),
                      DataCell(Expanded(child: Text('Total Population', style: TextStyle(fontSize: 14)))),
                      DataCell(Text('1857', style: TextStyle(fontSize: 14))),
                      DataCell(Text('962', style: TextStyle(fontSize: 14))),
                      DataCell(Text('895', style: TextStyle(fontSize: 14))),
                    ]),
                    DataRow(cells: [
                      DataCell(Expanded(child: Text('2', style: TextStyle(fontSize: 14)))),
                      DataCell(Expanded(child: Text('Child Population(0-6 Years)', style: TextStyle(fontSize: 14)))),
                      DataCell(Text('184', style: TextStyle(fontSize: 14))),
                      DataCell(Text('108', style: TextStyle(fontSize: 14))),
                      DataCell(Text('76', style: TextStyle(fontSize: 14))),
                    ]),
                    DataRow(cells: [
                      DataCell(Expanded(child: Text('3', style: TextStyle(fontSize: 14)))),
                      DataCell(Expanded(child: Text('Scheduled Caste Population', style: TextStyle(fontSize: 14)))),
                      DataCell(Text('254', style: TextStyle(fontSize: 14))),
                      DataCell(Text('129', style: TextStyle(fontSize: 14))),
                      DataCell(Text('125', style: TextStyle(fontSize: 14))),
                    ]),
                    DataRow(cells: [
                      DataCell(Expanded(child: Text('4', style: TextStyle(fontSize: 14)))),
                      DataCell(Expanded(child: Text('Scheduled Tribe Population', style: TextStyle(fontSize: 14)))),
                      DataCell(Text('1', style: TextStyle(fontSize: 14))),
                      DataCell(Text('0', style: TextStyle(fontSize: 14))),
                      DataCell(Text('1', style: TextStyle(fontSize: 14))),
                    ]),
                    DataRow(cells: [
                      DataCell(Expanded(child: Text('5', style: TextStyle(fontSize: 14)))),
                      DataCell(Expanded(child: Text('Literates Population', style: TextStyle(fontSize: 14)))),
                      DataCell(Text('1442', style: TextStyle(fontSize: 14))),
                      DataCell(Text('773', style: TextStyle(fontSize: 14))),
                      DataCell(Text('669', style: TextStyle(fontSize: 14))),
                    ]),
                    DataRow(cells: [
                      DataCell(Expanded(child: Text('6', style: TextStyle(fontSize: 14)))),
                      DataCell(Expanded(child: Text('Iliterates Population', style: TextStyle(fontSize: 14)))),
                      DataCell(Text('415', style: TextStyle(fontSize: 14))),
                      DataCell(Text('189', style: TextStyle(fontSize: 14))),
                      DataCell(Text('226', style: TextStyle(fontSize: 14))),
                    ]),
                    DataRow(cells: [
                      DataCell(Expanded(child: Text('7', style: TextStyle(fontSize: 14)))),
                      DataCell(Expanded(child: Text('Workers Population', style: TextStyle(fontSize: 14)))),
                      DataCell(Text('759', style: TextStyle(fontSize: 14))),
                      DataCell(Text('530', style: TextStyle(fontSize: 14))),
                      DataCell(Text('229', style: TextStyle(fontSize: 14))),
                    ]),
                    DataRow(cells: [
                      DataCell(Expanded(child: Text('8', style: TextStyle(fontSize: 14)))),
                      DataCell(Expanded(child: Text('Non Workers', style: TextStyle(fontSize: 14)))),
                      DataCell(Text('1098', style: TextStyle(fontSize: 14))),
                      DataCell(Text('432', style: TextStyle(fontSize: 14))),
                      DataCell(Text('666', style: TextStyle(fontSize: 14))),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(
        selectedRole: widget.selectedRole,
        aadharNo: widget.aadharNo,
        onNavigation: (route) {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
