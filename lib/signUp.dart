import 'package:flutter/material.dart';

void main()
{
  runApp(signUpPage());
}

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: Scaffold(
       body: Column(
         children: [
           Text("Sign Up"),
         ],
       ),
     )
    );
  }
}
