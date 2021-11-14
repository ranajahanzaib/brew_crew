import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          // ignore: deprecated_member_use
          child: Form(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.brown[500],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    print(email);
                    print(password);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
