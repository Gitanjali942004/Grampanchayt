import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grampanchayat/HomePage.dart';
import 'package:grampanchayat/signup.dart';
import 'CheckStatusScreen.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'ForgotPassword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

final TextEditingController _aadharNoController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String selectedRole = 'Gramasth'; // Initialize selectedRole with a default value

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(
        selectedRole: selectedRole, // Pass selectedRole to the LoginPage widget
        onRoleChanged: (newValue) {
          setState(() {
            selectedRole = newValue; // Update selectedRole in the parent widget
          });
        },
      ),
      routes: {
        '/home': (context) => HomePage(selectedRole: selectedRole, aadharNo: ModalRoute.of(context)!.settings.arguments as String),
        '/signup': (context) => SignUpPage(),
        '/forgotpassword': (context) => ForgotPasswordPage(),
        '/checkstatus':(context)=> CheckStatusScreen(aadharNo: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final String selectedRole; // Define selectedRole variable
  final Function(String) onRoleChanged; // Define a callback function

  LoginPage({required this.selectedRole, required this.onRoleChanged}); // Constructor to receive selectedRole and onRoleChanged

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA5D7E8),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Gram Sevice App"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Grampanchayat Potale ",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF0B2447),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/gl.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width, // Adjusts container width to screen width
                  height: 370, // You can adjust this height according to your requirement
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CustomDropdownMenu(
                          onChanged: onRoleChanged,
                        ),
                        TextFormField(
                          controller: _aadharNoController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.badge),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                            },
                            child: Text("Forgot Password?"),
                          ),
                        ),

                        SizedBox(
                          width: double.infinity, // Set width to match the parent container width
                          child: TextButton(
                            onPressed: () async {
                              if (selectedRole == 'Gramasth') {
                                // Query Firestore to check if the user exists
                                var snapshot = await FirebaseFirestore.instance
                                    .collection('users')
                                    .where('aadharCard', isEqualTo: _aadharNoController.text)
                                    .where('password', isEqualTo: _passwordController.text)
                                    .get();
                                if (snapshot.docs.isNotEmpty) {
                                  // User exists, navigate to the home page
                                  Navigator.pushNamed(
                                    context,
                                    '/home',
                                    arguments: _aadharNoController.text, // Pass Aadhar card number to HomePage
                                  );
                                } else {
                                  // User doesn't exist, show an alert
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Alert'),
                                        content: Text('Please enter correct Aadhar number or password!'),
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
                                }
                              } else if (selectedRole == 'Admin') {
                                // Admin login logic
                                if (_aadharNoController.text == 'admingram' &&
                                    _passwordController.text == 'admingram9999') {
                                  Navigator.pushNamed(context, '/home',arguments: _aadharNoController.text);
                                } else {
                                  // Show alert for incorrect credentials
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Alert'),
                                        content: Text('Please enter correct Aadhar number or password!'),
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
                                }
                              }
                            },
                            child: Text(
                              'Log In',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text("New User? Create New Account"),
                        ),

                      ],

                    ),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDropdownMenu extends StatefulWidget {
  final Function(String) onChanged;

  const CustomDropdownMenu({Key? key, required this.onChanged}) : super(key: key);

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String dropdownValue = 'Gramasth'; // Default value

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          widget.onChanged(newValue); // Call onChanged with the new value
        });
      },
      items: <String>['Gramasth', 'Admin']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
