import 'dart:ffi';

import 'package:brew_crew/screens/styles/text_input_decoration.dart';
import 'package:flutter/material.dart';
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Update Preferences',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration:
                textInputDecoration.copyWith(hintText: _currentName ?? 'Name'),
            initialValue: _currentName,
            validator: (val) =>
                val!.trim().isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => _currentName = val,
          ),
          SizedBox(height: 20),
          DropdownButtonFormField(
            value: _currentSugars ?? '0',
            decoration: textInputDecoration,
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Text('$sugar sugars'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentSugars = val as String?),
          ),
          Slider(
            label: 'Strength ' + (_currentStrength! / 100).round().toString() ??
                'Strength',
            min: 100,
            max: 900,
            divisions: 8,
            activeColor:
                Colors.brown[_currentStrength ?? 100]!.withOpacity(0.7),
            inactiveColor:
                Colors.brown[_currentStrength ?? 100]!.withOpacity(0.7),
            value: (_currentStrength ?? 100).toDouble(),
            onChanged: (val) => setState(() => _currentStrength = val.round()),
          ),
          RaisedButton(
            color: Colors.brown[500],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_currentName);
              print(_currentSugars);
              print(_currentStrength);
            },
          ),
        ],
      ),
    );
  }
}
