import "package:flutter/material.dart";
import 'package:widgetmaster/Services/auth.dart';
import 'package:widgetmaster/shared/constants.dart';
import 'package:widgetmaster/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  //basic connection to firebase auth
  final _formKey = GlobalKey<FormState>();
  //   to identify our form with this globalform state key
  bool loading = false;
  String email = '';
  String password = '';
  String _error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[300],
            appBar: AppBar(
              title: const Text("Register"),
              actions: <Widget>[
                ElevatedButton.icon(
                  label: Text("Sign-In"),
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    widget.toggleView(); //instead of this- for state widget
                    //we're accessing the register widget's function
                  },
                ),
              ],
              backgroundColor: Colors.blue[500],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(children: [
                Form(
                  key: _formKey, //created
                  //now we can do validation
                  child: Column(children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'email'),
                      validator: (val) =>
                          val!.isEmpty ? "Enter an email" : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'password'),
                      validator: (val) => val!.length < 6
                          ? "Enter a apassword 6 chars long"
                          : null,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        children: [
                          log,
                          TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                                primary: Colors.white,
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                //if textfielda were validated
                                //check with textformfieldwidget validatorproperty
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _auth
                                      .registerEmailPassword(email, password);
                                  //this userresult willbe transformed into data we need
                                  if (result == null) {
                                    setState(() {
                                      _error =
                                          "Please supply a valid email, or an email that does not already have an associated account";
                                      loading = false;
                                    });
                                    //now that we signed in,we must listen for the changes using streams
                                  } else {
                                    print("Regsitered User");
                                  }
                                }
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20,
                  child: Text(_error,
                      style: const TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                      )),
                ),
              ]),
            ), /**/
          );
  }
}
