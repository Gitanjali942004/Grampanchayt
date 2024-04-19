import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  final String selectedRole;
  final String aadharNo;

  const EditProfile({Key? key, required this.selectedRole, required this.aadharNo}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _aadharCardController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _homeNumberController = TextEditingController();
  TextEditingController _rationCardController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late DocumentSnapshot userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('aadharCard', isEqualTo: widget.aadharNo)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          userData = querySnapshot.docs.first;
          _nameController.text = userData['name'];
          _mobileNumberController.text = userData['mobileNumber'];
          _aadharCardController.text = userData['aadharCard'];
          _addressController.text = userData['address'];
          _homeNumberController.text = userData['homeNumber'];
          _rationCardController.text = userData['rationCard'];
          _dobController.text = userData['dob'];
          _ageController.text = userData['age'];
          _passwordController.text = userData['password'];
        });
      } else {
        throw Exception('No matching document found');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  void updateProfile() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userData.id)
          .update({
        'name': _nameController.text,
        'mobileNumber': _mobileNumberController.text,
        'aadharCard': _aadharCardController.text,
        'address': _addressController.text,
        'homeNumber': _homeNumberController.text,
        'rationCard': _rationCardController.text,
        'dob': _dobController.text,
        'age': _ageController.text,
        'password': _passwordController.text,
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Profile updated successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error updating user data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Mobile Number:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _mobileNumberController,
                decoration: InputDecoration(
                  hintText: 'Enter your mobile number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              Text(
                'Aadhar Card Number:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _aadharCardController,
                decoration: InputDecoration(
                  hintText: 'Enter your Aadhar card number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Address:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Enter your address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Home Number:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _homeNumberController,
                decoration: InputDecoration(
                  hintText: 'Enter your home number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              Text(
                'Ration Card Number:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _rationCardController,
                decoration: InputDecoration(
                  hintText: 'Enter your ration card number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Date of Birth:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  hintText: 'Enter your date of birth',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Age:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  hintText: 'Enter your age',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.accessibility),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Text(
                'Password:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: updateProfile,
                child: Text('Update Profile', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
