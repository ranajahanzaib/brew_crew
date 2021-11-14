import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/auth/auth.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return AuthScreen();
    } else {
      return HomeScreen();
    }
  }
}
