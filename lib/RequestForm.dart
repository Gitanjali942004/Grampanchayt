import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:grampanchayat/RequestForm.dart';
import 'package:grampanchayat/MyDrawer.dart';
import 'package:grampanchayat/HomePage.dart';
import 'package:grampanchayat/AboutUs.dart';
import 'package:grampanchayat/CheckRequest.dart';
import 'package:grampanchayat/ContactUs.dart';
import 'package:grampanchayat/ForgotPassword.dart';
import 'package:grampanchayat/EditProfile.dart';
import 'package:grampanchayat/CheckStatusScreen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String selectedRole = 'Gramasth';
  final String aadharNo = '1234567890'; // Example Aadhar number

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RequestForm(selectedRole: selectedRole, aadharNo: aadharNo), // Pass selectedRole and aadharNo
      routes: {
        '/home': (context) => HomePage(selectedRole: selectedRole, aadharNo: aadharNo),
        '/request': (context) => RequestForm(selectedRole: selectedRole, aadharNo: aadharNo),
        '/checkrequest':(context) => CheckRequest(selectedRole: selectedRole),
        '/aboutus':(context) => AboutUs(selectedRole: selectedRole,aadharNo: aadharNo),
        '/contactus':(context) => ContactUs(selectedRole: selectedRole, aadharNo: aadharNo), // Pass selectedRole and aadharNo to ContactUs
        '/editprofile':(context) => EditProfile(selectedRole: selectedRole, aadharNo: aadharNo),
        '/checkstatus':(context)=> CheckStatusScreen(aadharNo: aadharNo),
      },
    );
  }
}

class RequestForm extends StatefulWidget {
  final String selectedRole;
  final String aadharNo;

  const RequestForm({Key? key, required this.selectedRole, required this.aadharNo}) : super(key: key);

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
  List<String> _documentTypes = ['जन्मनोंद दाखला', 'रहीवाशी दाखला', '7/12','मृत्युनोंद दाखला','दारिद्रय रेषेखालील दाखला','नमुना 8चा उतारा'];
  FilePickerResult? _file;
  DateTime? _selectedDate;

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
        _file = result;
      });
    }
  }

  Future<void> senddata() async {
    String formattedDate = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : '';

    CollectionReference requestCollection = FirebaseFirestore.instance.collection('requests');

    await requestCollection.add({
      'name': _nameController.text,
      'mobile': _mobileController.text,
      'dob': formattedDate,
      'age': _ageController.text,
      'adhar': _adharController.text,
      'username': widget.aadharNo, // Assign the Aadhar number passed to RequestForm
      'purpose': _purposeController.text,
      'documentType': _documentType,
      'status': 'pending',
    });

    _nameController.clear();
    _mobileController.clear();
    _dobController.clear();
    _ageController.clear();
    _adharController.clear();
    _purposeController.clear();
    _documentType = null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Form"),
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
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
                    return 'Please enter purpose';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    senddata();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Form submitted successfully!'),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(
        selectedRole: widget.selectedRole, // Access selectedRole from widget
        aadharNo: widget.aadharNo, // Access aadharNo from widget
        onNavigation: (route) {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
