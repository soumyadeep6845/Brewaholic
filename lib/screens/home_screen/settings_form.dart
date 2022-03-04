import 'package:brew_app/models/user.dart';
import 'package:brew_app/services/database.dart';
import 'package:brew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_app/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String? _currentName;
  late String? _currentSugars;
  late int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          UserData? userData = snapshot.data;

          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings!',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  //Dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugars = val.toString()),
                  ),
                  //Slider
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                  ),
                  RaisedButton(
                    color: Colors.brown[400],
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
