import 'package:brew_crew/screens/styles/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/screens/styles/text_input_decoration.dart';

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
              title: Text('Register'),
              actions: [
                // ignore: deprecated_member_use
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
                        validator: (val) => val!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        obscureText: true,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      // ignore: deprecated_member_use
                      RaisedButton(
                        color: Colors.brown[500],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic user = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (user == null) {
                              setState(() {
                                error = 'Please supply a valid email';
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
