import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  RegisterScreen({required this.toggleView});

  // const RegisterScreen({Key? key, this.toggleView}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register'),
        actions: [
          FlatButton.icon(
            onPressed: () => widget.toggleView(),
            icon: Icon(Icons.person, color: Colors.white),
            label: Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          // ignore: deprecated_member_use
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
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
                  validator: (val) =>
                      val!.length < 6 ? 'Enter a password 6+ chars long' : null,
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
                    if (_formKey.currentState!.validate()) {
                      dynamic user = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (user == null) {
                        setState(() => error = 'Please supply a valid email');
                      }
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
