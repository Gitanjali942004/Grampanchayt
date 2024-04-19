
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
      home: ContactUs(selectedRole: selectedRole, aadharNo: aadharNo),
      routes: {
        '/h': (context) => HomePage(selectedRole: selectedRole, aadharNo: aadharNo),
        '/home':(context) =>HomePage(selectedRole: selectedRole, aadharNo: aadharNo),
        '/request': (context) => RequestForm(selectedRole: selectedRole, aadharNo: aadharNo),
        '/checkrequest': (context) => CheckRequest(selectedRole: selectedRole),
        '/aboutus': (context) => ContactUs(selectedRole: selectedRole, aadharNo: aadharNo),
        '/contactus': (context) => ContactUs(selectedRole: selectedRole, aadharNo: aadharNo),
        '/editprofile': (context) => EditProfile(selectedRole: selectedRole, aadharNo: aadharNo),

      },
    );
  }
}

class ContactUs extends StatefulWidget {
  final String selectedRole;
  final String aadharNo;

  const ContactUs({Key? key, required this.selectedRole, required this.aadharNo}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Number of Sarpanchs
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Sarpanch $index",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Image.asset(
                            'assets/images/d1.png', // Provide path to your image
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Name:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Contact Number:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Designation:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Sarpanch Name $index"),
                                    Text("Sarpanch Contact Number $index"),
                                    Text("Sarpanch Designation $index"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Add onPressed action here
                            },
                            child: Text("View Profile"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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


//code which include sarpanch card view and alll
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   final String selectedRole = 'ग्रामस्थ';
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Form Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: AboutUs(selectedRole: selectedRole,),
//     );
//   }
// }
//
// class AboutUs extends StatefulWidget {
//   final String selectedRole;
//
//   const AboutUs({Key? key, required this.selectedRole}) : super(key: key);
//   @override
//   _AboutUsState createState() => _AboutUsState();
// }
//
// class _AboutUsState extends State<AboutUs> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Color(0xFFA5D7E8),
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text("Grampanchayat App"),
//         leading: IconButton(
//           icon: Icon(Icons.menu), // Hamburger icon
//           onPressed: () {
//             _scaffoldKey.currentState?.openDrawer(); // Open the Drawer
//           },
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               "ग्रामपंचायत पोतले",
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Color(0xFF0B2447),
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 4, // Number of Sarpanchs
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     elevation: 4,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             "Sarpanch $index",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           SizedBox(height: 10),
//                           Image.asset(
//                             'assets/images/sarpanch_$index.jpg', // Provide path to your image
//                             height: 100,
//                             width: 100,
//                             fit: BoxFit.cover,
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       "Name:",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Text(
//                                       "Contact Number:",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Text(
//                                       "Designation:",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 3,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Sarpanch Name $index"),
//                                     Text("Sarpanch Contact Number $index"),
//                                     Text("Sarpanch Designation $index"),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           ElevatedButton(
//                             onPressed: () {
//                               // Add onPressed action here
//                             },
//                             child: Text("View Profile"),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }