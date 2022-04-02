// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:widgetmaster/Services/auth.dart';
import 'package:widgetmaster/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:widgetmaster/models/product.dart';
import 'package:widgetmaster/screens/home/product_list.dart';
import 'package:widgetmaster/screens/home/product_tile.dart';
import 'package:widgetmaster/screens/home/settings_form.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  List<Widget> v = [];

  void buildRow(String name, String price) {
    v.add(Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue,
        child: Card(
          //width:double.infinity,
          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Text(name),
                ),
                title: Text(name),
                subtitle: Text("\$" + price.toString()),
                trailing: Text(
                  "x1",
                  style: TextStyle(color: Colors.lightBlue),
                  textScaleFactor: 1.2,
                ),
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
//function created here becausewe need access to cntext
    void _showSettingsPanel() {
      //this is a built in flutter widget fucntion
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Product>>.value(
        //was snapshot query
        initialData: [], //was null,
        value: DatabaseService().orders,
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 138, 59, 31),
            appBar: AppBar(
              title: Text("WAz d scene bhai cassle bhaii"),
              backgroundColor: Colors.amberAccent,
              elevation: 0.0,
              actions: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(20),
                )),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    //can also use textbutton
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Bhaii"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                      onPressed: () {
                        _showSettingsPanel();
                      },
                      icon: Icon(Icons.settings),
                      label: Text("Settings")),
                ),
              ], //actions inappbar expects widgetlist of buttons
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/murica.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(children: [
                ProductsList(),
                
              ]),
            )));
  } /*Flexible(
                  flex: 6,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton.icon(
                              onPressed: () async {
                                setState(() => buildRow("Bhaiii", "bhi"));
                              },
                              icon: Icon(Icons.import_contacts_rounded),
                              label: Text("See profiles")),
                          // 
                        ],
                        //ElevatedButton(child: Image(image: AssetImage()),)
                      ),
                    ),
                  )),*/

}



/*Expanded(
              flex: 3,
              child: Wrap(children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Container(
                    color: Colors.grey,
                    width: 700,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: 500,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 100,
                          width: 300,
                          color: Colors.red,
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              color: Colors.yellow,
                              height: 100,
                              width: 100,
                              child: RichText(
                                text: const TextSpan(
                                    text: " dog",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                          FontWeight.w700, //FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: " See how much I've grown rat",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      )
                                    ]),
                              ),
                            )),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              color: Colors.green,
                              height: 100,
                              width: 100,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            1, 10, 10, 0),
                                        child: Icon(
                                          Icons.developer_mode_sharp,
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '  Tinkle is Powered By:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ]),
            ),*/

