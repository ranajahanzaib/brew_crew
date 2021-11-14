import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Brew Crew'),
          elevation: 0.0,
          // centerTitle: true,
          actions: [
            // ignore: deprecated_member_use
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                )),
            // ignore: deprecated_member_use
            FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.white),
              label: Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/coffee_bg.png'),
                      fit: BoxFit.cover)),
              child: BrewList()),
        ),
      ),
    );
  }
}
