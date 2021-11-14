import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/styles/loading.dart';
import 'package:brew_crew/screens/styles/text_input_decoration.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:brew_crew/screens/styles/'

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return StreamBuilder<AppUserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AppUserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update Preferences',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    decoration: textInputDecoration,
                    initialValue: userData?.name,
                    validator: (val) =>
                        val!.trim().isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => _currentName = val,
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    value: _currentSugars ?? userData?.sugars,
                    decoration: textInputDecoration,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugars = val as String?),
                  ),
                  SizedBox(height: 40),
                  Slider(
                    label: _currentStrength?.round().toString(),
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor: Colors
                        .brown[_currentStrength ?? userData!.strength]!
                        .withOpacity(0.7),
                    inactiveColor: Colors
                        .brown[_currentStrength ?? userData!.strength]!
                        .withOpacity(0.7),
                    value: (_currentStrength ?? userData!.strength).toDouble(),
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.brown[500],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData!.sugars,
                          _currentName ?? userData!.name,
                          _currentStrength ?? userData!.strength,
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
