// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetmaster/Services/auth.dart';
//import 'package:widgetmaster/mine.dart';
import 'package:widgetmaster/screens/authenticate/authenticate.dart';
import 'package:widgetmaster/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:widgetmaster/screens/authenticate/sign_in.dart';
import 'package:widgetmaster/models/currentuser.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:widgetmaster/screens/home/dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (defaultTargetPlatform == TargetPlatform.android) {
// Android specific code

  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
  } else {
//web or desktop specific code
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        home: WebViewPlusExampleMainPage(), //Wrapper(),
      ),
    );
  }
}

class WebViewPlusExampleMainPage extends StatefulWidget {
  const WebViewPlusExampleMainPage({Key? key}) : super(key: key);

  @override
  _WebViewPlusExampleMainPageState createState() =>
      _WebViewPlusExampleMainPageState();
}

class _WebViewPlusExampleMainPageState
    extends State<WebViewPlusExampleMainPage> {
  WebViewPlusController? _controller;
  double _height = 200;
  String htmlpage = ''' <!DOCTYPE html>
<html>
<body>

<h2>Example to load html from string</h2>

<p>This is paragraph 1</p>

<img src="https://thumbs.dreamstime.com/b/sun-rays-mountain-landscape-5721010.jpg"  width="250" height="250">

</body>
</html>''';
  void loadLocalHTML() async {
    final url = Uri.dataFromString(
      htmlpage,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    _controller!.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('webview_flutter_plus Example'),
        ),
        body: ListView(children: [
          Text("Height of WebviewPlus: $_height",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: _height,
            //width: 300,
            child: WebViewPlus(
              //serverPort: 5353,
              javascriptChannels: null,
              initialUrl: 'assets/index.html',
              onWebViewCreated: (controller) {
                this._controller = controller;
                loadLocalHTML();
              },

              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ]));
  }
}
