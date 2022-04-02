import 'package:flutter/material.dart';
import 'package:widgetmaster/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:widgetmaster/screens/authenticate/sign_in.dart';
import 'package:widgetmaster/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _showSignIn = false;

  void toggleView() {
    setState(() {
      if (_showSignIn == true) {
        _showSignIn = false;
      } else {
        if (_showSignIn == false) _showSignIn = true;
      }
    });
  }

  String _vname = "Please click me";
  @override
  Widget build(BuildContext context) {
    if (_showSignIn) {
      return SignIn(
          toggleView:
              toggleView); //we created a function to send/pass to the widge.Upon execution ,a state will change across the app
    } else
      return Register(toggleView: toggleView);
  }
}
