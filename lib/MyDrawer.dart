import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String selectedRole;
  final Function(String) onNavigation; // Callback for navigation

  const MyDrawer({
    Key? key,
    required this.selectedRole,
    required this.onNavigation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
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
            onTap: () => onNavigation('/home'),
          ),
          if (selectedRole == 'ग्रामस्थ')
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' Issue Request '),
              onTap: () => onNavigation('/request'),
            ),
          if (selectedRole == 'अ‍ॅडमिन')
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' Check Request '),
              onTap: () => onNavigation('/checkrequest'),
            ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text(' About Us'),
            onTap: () => onNavigation('/aboutus'),
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: const Text(' Contact Us '),
            onTap: () => onNavigation('/contactus'),
          ),
          if (selectedRole == 'ग्रामस्थ')
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile '),
              onTap: () => onNavigation('/editprofile'),
            ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () => Navigator.pop(context), // Close drawer
          ),
        ],
      ),
    );
  }
}
