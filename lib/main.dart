import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/auth_wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BrewCrewApp());
}

class BrewCrewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      catchError: (_, __) => null,
      value: AuthService().user,
      child: MaterialApp(
        home: AuthWrapper(),
      ),
    );
  }
}
