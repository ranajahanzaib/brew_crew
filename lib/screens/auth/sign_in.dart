import 'package:brew_crew/screens/auth_wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          // ignore: deprecated_member_use
          child: RaisedButton(
            child: Text('Sign In Anonymously'),
            onPressed: () async {
              dynamic user = await _auth.signInAnonymously();
              if (user == null) {
                print('Error signing in');
              } else {
                print('Signed in');
                print(user.uid);
              }
              // Navigator.pushNamed(context, '/');
            },
          ),
        ),
      ),
    );
  }
}
