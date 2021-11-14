import 'package:brew_crew/screens/auth_wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BrewCrewApp());
}

class BrewCrewApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthWrapper(),
    );
  }
}
