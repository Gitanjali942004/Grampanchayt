import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SignUpPage());
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _aadharCardController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _homeNumberController = TextEditingController();
  TextEditingController _rationCardController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to handle sign-up
  void signUp() {
    // Retrieve values from controllers
    String name = _nameController.text;
    String mobileNumber = _mobileNumberController.text;
    String aadharCard = _aadharCardController.text;
    String address = _addressController.text;
    String homeNumber = _homeNumberController.text;
    String rationCard = _rationCardController.text;
    String dob = _dobController.text;
    String age = _ageController.text;
    String password = _passwordController.text;

    // Prepare a map with the user data including the password
    Map<String, dynamic> userData = {
      'name': name,
      'mobileNumber': mobileNumber,
      'aadharCard': aadharCard,
      'address': address,
      'homeNumber': homeNumber,
      'rationCard': rationCard,
      'dob': dob,
      'age': age,
      'password': password, // Include the password field
      // Add more fields if necessary
    };

    // Store the user data in Firestore
    _firestore.collection('users').add(userData)
        .then((value) {
      // Show success alert
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User data added successfully!'),
            actions: <Widget>[
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
    })
        .catchError((error) {
      // Show error alert
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add user data: $error'),
            actions: <Widget>[
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          backgroundColor: Colors.green, // Customize app bar color
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
                  keyboardType: TextInputType.phone, // Set keyboard type
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
                  keyboardType: TextInputType.number, // Set keyboard type
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
                  keyboardType: TextInputType.phone, // Set keyboard type
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
                  obscureText: true, // Hide password
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: signUp, // Call signUp function on button press
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16), // Adjust button padding
                    minimumSize: Size(double.infinity, 50), // Set button size
                    primary: Colors.green, // Set button background color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
