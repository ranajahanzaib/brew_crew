import 'package:brew_crew/screens/auth_wrapper.dart';
import 'package:brew_crew/screens/styles/loading.dart';
import 'package:brew_crew/screens/styles/text_input_decoration.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  final Function toggleView;
  SignInScreen({required this.toggleView});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign In'),
              actions: [
                FlatButton.icon(
                  onPressed: () => widget.toggleView(),
                  icon: Icon(Icons.person, color: Colors.white),
                  label: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        obscureText: true,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.brown[500],
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic user = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (user == null) {
                              setState(() {
                                error =
                                    "Sorry, that didn't work. Please, try again.";
                                loading = false;
                              });
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
