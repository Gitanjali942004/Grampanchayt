import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyDrawer extends StatefulWidget {
  final String selectedRole;
  final String aadharNo; // Aadhar card number
  final Function(String) onNavigation; // Callback for navigation

  const MyDrawer({
    Key? key,
    required this.selectedRole,
    required this.aadharNo,
    required this.onNavigation,
  }) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    if (widget.selectedRole != 'Admin') {
      fetchUserData();
    } else {
      setState(() {
        userData = {'name': 'Admin'};
      });
    }
  }

  Future<void> fetchUserData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('aadharCard', isEqualTo: widget.aadharNo)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final documentSnapshot = querySnapshot.docs.first;
        setState(() {
          userData = documentSnapshot.data() as Map<String, dynamic>?;
        });
      } else {
        throw Exception('No matching document found');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[200], // Background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green, // Header background color
              ),
              child: userData != null
                  ? UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        userData!['name']?[0] ?? 'A',
                        style: TextStyle(
                            fontSize: 30.0, color: Colors.blue),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      userData!['name'] ?? 'Name not available',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                accountEmail: widget.selectedRole != 'Admin'
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData!['mobileNumber'] ??
                          'Mobile number not available',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Aadhar No.: ${widget.aadharNo}',
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                )
                    : null,
                currentAccountPicture: null,
              )
                  : Container(),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(' Home '),
              onTap: () => widget.onNavigation('/home'), // Navigate to '/home' route
            ),
            if (widget.selectedRole == 'Gramasth')
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text(' Issue Request '),
                onTap: () => widget.onNavigation('/request'),
              ),
            if (widget.selectedRole == 'Gramasth')
              ListTile(
                leading: const Icon(Icons.check),
                title: const Text(' Check Status '),
                onTap: () => widget.onNavigation('/checkstatus'),
              ),

            if (widget.selectedRole == 'Admin')
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text(' Check Request '),
                onTap: () => widget.onNavigation('/checkrequest'),
              ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text(' About Us'),
              onTap: () => widget.onNavigation('/aboutus'),
            ),
            if (widget.selectedRole == 'Gramasth')
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(' Edit Profile '),
                onTap: () => widget.onNavigation('/editprofile'),
              ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (e) {
                  print('Error signing out: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
