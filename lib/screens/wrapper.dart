import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetmaster/screens/home/home.dart';
import 'package:widgetmaster/screens/authenticate/authenticate.dart';
import 'package:widgetmaster/models/currentuser.dart';
import 'package:widgetmaster/screens/authenticate/sign_in.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);
    print(user);

    if (user == null || user == "") {
      return Authenticate();
    } else
      return Home();
    //return either home or authenticate widget
  }
}
