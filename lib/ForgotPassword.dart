import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _aadharCardController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _reenterPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA5D7E8),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Forgot Password"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/pas.png'),
              ),
              SizedBox(height: 10),
              Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _aadharCardController,
                          decoration: InputDecoration(
                            labelText: 'Enter Aadhar Card',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.badge),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _newPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Enter New Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.password),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _reenterPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Re-enter the Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.password_rounded),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _resetPassword(context);
                          },
                          child: Text('Reset Password', style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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

  void _resetPassword(BuildContext context) async {
    String aadharCard = _aadharCardController.text;
    String newPassword = _newPasswordController.text;
    String reenteredPassword = _reenterPasswordController.text;

    if (newPassword.isEmpty || reenteredPassword.isEmpty) {
      _showErrorDialog(context, "Passwords cannot be empty");
      return;
    }

    if (newPassword != reenteredPassword) {
      _showErrorDialog(context, "Passwords do not match");
      return;
    }

    try {
      // Retrieve the document ID of the user based on the entered aadharCard
      String userId = await getUserIdFromAadharCard(aadharCard);

      // Update the password field in the Firestore users collection
      await FirebaseFirestore.instance.collection('users').doc(userId).update({'password': newPassword});

      // Show success message
      _showSuccessMessage(context, "Password reset successfully");
    } catch (error) {
      // Show error message
      _showErrorDialog(context, "Failed to reset password: $error");
    }
  }

  Future<String> getUserIdFromAadharCard(String aadharCard) async {
    try {
      // Perform a query to find the user document with the matching Aadhar Card
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('aadharCard', isEqualTo: aadharCard)
          .get();

      // If a document is found, return its ID
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        throw 'User not found';
      }
    } catch (error) {
      throw 'Error retrieving user ID: $error';
    }
  }

  void _showSuccessMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
