import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _reenterController = TextEditingController();

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Forgot Your Password?",
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
                backgroundImage:
                AssetImage('assets/images/lock_icon.png'), // You can replace this with your lock icon
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
                  width: MediaQuery.of(context).size.width, // Adjusts container width to screen width
                  height: 300, // You can adjust this height according to your requirement
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
                          controller: _emailController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Enter New Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.password),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _reenterController,
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
                            if (_emailController.text == _reenterController.text) {
                              _resetPassword(_emailController.text);

                            }
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

  void _resetPassword(String email) {
    // Implement your password reset logic here
    // Typically, you would send a reset password link to the provided email
    // You can use email validation logic to ensure that the email is valid before sending the reset link
    print('Reset Password for $email');
    // You can navigate to a success page or show a message indicating that the reset link has been sent
  }

}
