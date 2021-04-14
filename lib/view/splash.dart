import 'dart:async';

import 'package:employee_records/view/employee.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

@override
void initState() { 
  super.initState();
   Timer(
              Duration(seconds: 3),
              () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => employee())));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Employees Application Launching..."),
      ),
    );
  }
}