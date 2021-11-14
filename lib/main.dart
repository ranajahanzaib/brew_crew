import 'package:brew_crew/screens/auth/auth.dart';
import 'package:brew_crew/screens/home/home.dart';
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return StreamProvider<AppUser?>.value(
    //   value: AuthService().user,
    //   initialData: null,
    //   child: MaterialApp(
    //     home: AuthWrapper(),
    //   ),
    // );
    return StreamBuilder(
      stream: AuthService().user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(home: HomeScreen());
        } else {
          return MaterialApp(
            home: AuthWrapper(),
          );
        }
      },
    );
  }
}
