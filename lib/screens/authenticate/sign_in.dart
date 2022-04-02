import 'package:flutter/material.dart';
import 'package:widgetmaster/Services/auth.dart';
import 'package:widgetmaster/shared/constants.dart';
import 'package:widgetmaster/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;//this is how you send something to a wdget,by just declaring it within the cclass
  SignIn({required this.toggleView});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //create instance of our classes(authservice) within state objects-signin
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  //   to identify our form with this globalform state key
  bool loading = false;

  String email = '';
  String password = '';
  String error = "";
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[300],
            appBar: AppBar(
              title: const Text("LogIn"),
              actions: <Widget>[
                ElevatedButton.icon(
                  label: Text("Register"),
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
              backgroundColor: Colors.blue[500],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(children: [
                Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      //decoration created in the constants file(shared)
                      //this solves your overwrite widget issue rat!
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
                      obscureText: true,
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
                        children: <Widget>[
                          log,
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _auth
                                    .signInEmailPassword(email, password);
                                //this userresult willbe transformed into data we need
                                if (result != null) {
                                  //print("Signed In with user Id: ");
                                  //print(result.uid); //
                                  //now that we signed in,we must listen for the changes using streams
                                } else {
                                  setState(() {
                                    loading = false;
                                    error =
                                        "Could not sign in with those credentials";
                                  });
                                }
                              }
                            },
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(error,
                          style: const TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                          )),
                    ),
                  ]),
                ),
              ]),
            ), /**/
          );
  }
}
