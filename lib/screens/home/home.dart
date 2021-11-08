import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/setting_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.white12,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: const Setting(),
            );
          });
    }

    final user5 = Provider.of<Users>(context);
    return StreamProvider<List<Brew>>.value(
      initialData: const [],
      value: Database(uid: user5.uid).brews,
      child: Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            title: const Text("Brew Crew"),
            backgroundColor: Colors.brown[400],
            elevation: 0,
            actions: [
              TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: const Icon(Icons.person),
                label: const Text('Log Out'),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
              ),
              TextButton.icon(
                  onPressed: () => _showSettingPanel(),
                  icon: const Icon(Icons.settings),
                  label: const Text('Settings'),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.white))),
            ],
          ),
          // body: const BrewList(),
          body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('image/coffee_bg.png'),
                    fit: BoxFit.cover),
              ),
              child: const BrewList())),
    );
  }
}
