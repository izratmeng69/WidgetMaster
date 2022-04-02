import 'package:flutter/material.dart';
import 'package:widgetmaster/Services/database.dart';
import 'package:widgetmaster/models/currentuser.dart';
import 'package:widgetmaster/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:widgetmaster/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  //SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  String? _currentName;
  double? _price;
  String _currentIcening =
      "Chocolate"; //This is the selection value. It is also present in my array.
  final _icening = [
    "Chocolate",
    "Vanilla",
    "Strawberry",
    "Coconut"
  ]; //This is the array for dropdown
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);
    //vecause we needto acesss context
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid)
            .userData, //this creates a databaseservice onject with our current user id
        builder: (context, snapshot) {
          //nothing to do with firebase, this is a built influtter stream
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            return Form(
              key: _formKey,
              child: Column(children: [
                const Expanded(
                  child: Text("Update form settings"),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration.copyWith(
                          hintText: "Ënter your name"),
                      validator: (val) =>
                          val!.isEmpty ? "Enter a username" : null,
                      onChanged: (val) => setState(() => _currentName = val)),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                //slider

                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField(
                    decoration:
                        textInputDecoration, //(hintText: "Select icening"),
                    value: _currentIcening,
                    items: _icening
                        .map((String item) => DropdownMenuItem<String>(
                            child: Text(item), value: item))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        this._currentIcening = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Slider(
                    activeColor: Colors.brown, //shade the slider
                    inactiveColor:
                        Colors.brown[_price?.toInt() ?? userData.price],
                    value: _price ?? userData.price.toDouble(),
                    onChanged: (val) {
                      setState(() {
                        _price = val; //rounds double to neaerest int
                      });
                    },
                    min: 100,
                    max: 900,
                    divisions: 8, //spaces in between 1-9
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print(_currentName);
                        print(_currentIcening);
                        print(_price);
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            (_price ?? userData.price).toInt());
                        Navigator.pop(context);
                      } else {}
                    },
                    child: Text("Purchase"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                  ),
                ),
              ]),
            );
          } else {
            return Loading();
          }
        });
  }
}
