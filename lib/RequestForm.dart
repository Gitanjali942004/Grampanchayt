import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:grampanchayat/ContactUs.dart';
import 'package:grampanchayat/EditProfile.dart';
import 'package:intl/intl.dart';
import 'AboutUs.dart';
import 'CheckRequest.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String selectedRole = 'ग्रामस्थ';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RequestForm(selectedRole: selectedRole),
      routes: {
        '/request': (context) => RequestForm(selectedRole: selectedRole),
        '/checkrequest':(context) => CheckRequest(selectedRole: selectedRole),
        '/aboutus':(context) => AboutUs(selectedRole: selectedRole),
        '/contactus':(context) => ContactUs(selectedRole: selectedRole),
        '/editprofile':(context) => EditProfile(selectedRole: selectedRole),

      },
    );
  }
}

class RequestForm extends StatefulWidget {
  final String selectedRole;

  const RequestForm({Key? key, required this.selectedRole}) : super(key: key);

  @override
  _RequestFormState createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {


  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _adharController = TextEditingController();
  TextEditingController _purposeController = TextEditingController();
  String? _documentType;
  List<String> _documentTypes = ['Passport', 'ID Card', 'Driver License'];
  PlatformFile? _file;
  DateTime? _selectedDate;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  popup()
  {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data inserted successfully!'),
        duration: Duration(seconds: 5), // Adjust the duration as needed
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _file = result.files.first;
      });
    }
  }

  Future<void> senddata() async {
    // Format the date
    String formattedDate = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : '';

    final response = await http.post(
      Uri.parse("http://localhost/GrampanchayatApp/insertRequest.php"),
      body: {
        "name": _nameController.text,
        "mobile": _mobileController.text,
        "dob": formattedDate, // Use the formatted date
        "age": _ageController.text,
        "adhar": _adharController.text,
        "purpose": _purposeController.text
      },
    );
    var datauser = json.decode(response.body);
  }



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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              InkWell(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  prefixIcon: Icon(Icons.date_range),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _adharController,
                decoration: InputDecoration(
                  labelText: 'Adhar Number',
                  prefixIcon: Icon(Icons.credit_card),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your Adhar number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField(
                value: _documentType,
                items: _documentTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _documentType = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Document Type',
                  prefixIcon: Icon(Icons.insert_drive_file),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select document type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _purposeController,
                decoration: InputDecoration(
                  labelText: 'Purpose',
                  prefixIcon: Icon(Icons.note),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter purpose';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ration Card",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  ElevatedButton(
                    onPressed:_selectFile,
                    child: Text('Upload'),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              _file != null
                  ? Text('File Selected: ${_file!.name}')
                  : SizedBox(),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the form data
                    // You can access form field values using controllers like _nameController.text, _mobileController.text, etc.
                    // Add your submit logic here
                    senddata();
                    popup();
                    print('Form is valid');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
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
              title: const Text(' Issue Request '),
              onTap: () {
                Navigator.pushNamed(context, '/request');
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
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile '),
              onTap: () {
                Navigator.pushNamed(context, '/editprofile');
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

