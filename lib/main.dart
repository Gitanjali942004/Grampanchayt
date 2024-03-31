import 'package:flutter/material.dart';
import 'package:grampanchayat/HomePage.dart';

void main() {
  runApp(MyApp());
}

final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String selectedRole='ग्रामस्थ'; // Define selectedRole variable

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(
        onRoleChanged: (newValue) {
          setState(() {
            selectedRole = newValue; // Update selectedRole in the parent widget
          });
        },
      ),
      routes: {
        '/home': (context) => HomePage(selectedRole: selectedRole),
      },
    );
  }
}


class LoginPage extends StatelessWidget {
  final Function(String) onRoleChanged; // Define a callback function

  LoginPage({required this.onRoleChanged}); // Constructor to receive the callback function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA5D7E8),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Grampanchayat App"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "ग्रामपंचायत पोतले ",
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
                radius: 50,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/Uni2.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                "लॉगिन",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 600,
                  height: 340,
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
                          onChanged: onRoleChanged, // Pass the callback function to CustomDropdownMenu
                        ),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'वापरकर्ता आयडी',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'पासवर्ड',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "तुमचा पासवर्ड विसरला?",
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  print("Button");
                                  Navigator.pushNamed(context, '/home');
                                },
                                child: Text('लॉगिन करा'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text("नविन युजर? नविन खाते उघडा"),
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
  String dropdownValue = 'ग्रामस्थ'; // Default value

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
      items: <String>['ग्रामस्थ', 'अ‍ॅडमिन']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
