// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetmaster/Services/auth.dart';
import 'package:widgetmaster/mine.dart';
import 'package:widgetmaster/screens/authenticate/authenticate.dart';
import 'package:widgetmaster/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:widgetmaster/screens/authenticate/sign_in.dart';
import 'package:widgetmaster/models/currentuser.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*Stripe.publishableKey =
      "pk_test_51KjUWlI0d3pFCmRmWVtxZq8zZtSsbeSy60STPAoimuTpVXWQHud65ro0DKeDN9Z2gichiyyArn0OCgUlzzglFfXC00zyeyH0vA";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CurrentUser curr = CurrentUser(uid: "1");
    //wrap material app with streamrpovider that changes app
    //depending on changesin the authentication service -lo/sinout/in
    return StreamProvider<CurrentUser?>.value(
      initialData: curr,
      //variable curr wascreated

      value: AuthService().user, //stream to listen to
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
