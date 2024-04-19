import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    if (widget.selectedRole != 'अ‍ॅडमिन') {
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
                accountEmail: widget.selectedRole != 'अ‍ॅडमिन'
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
              onTap: () => widget.onNavigation('/home'),
            ),
            if (widget.selectedRole == 'ग्रामस्थ')
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text(' Issue Request '),
                onTap: () => widget.onNavigation('/request'),
              ),
            if (widget.selectedRole == 'अ‍ॅडमिन')
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
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text(' Our Team '),
              onTap: () => widget.onNavigation('/contactus'),
            ),
            if (widget.selectedRole == 'ग्रामस्थ')
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(' Edit Profile '),
                onTap: () => widget.onNavigation('/editprofile'),
              ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, '/login'); // Navigate to login page (LoginPage)
              },
            ),
          ],
        ),
      ),
    );
  }
}
