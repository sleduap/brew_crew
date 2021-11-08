import 'dart:ui';

import 'package:brew_crew/constant/constant.dart';
import 'package:brew_crew/constant/loading.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  late dynamic _currentName;
  String? _currentSugars;
  // late dynamic _currentStrength = 100;
  int? _currentStrength;
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    // dynamic _currentStrength = 100;
    return StreamBuilder<UserData>(
        stream: Database(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            // dynamic _currentStrength = userData!.strength;

            return Form(
                key: _formkey,
                child: Column(
                  children: [
                    const Text(
                      'Update Brew Settings',
                      style: TextStyle(fontSize: 18),
                    ),
                    // Text("$_currentName"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: userData!.name,
                      decoration: textInputdec.copyWith(
                        hintText: 'Name',
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a name' : null,
                      //we can use onChanged instead of unsaved by declaring _current name as String? instead of dynamic and using _currentName ?? userData.name for null checker in elevated button  Updatedata()function
                      onSaved: (val) {
                        setState(() {
                          _currentName = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //dropdown
                    DropdownButtonFormField(
                      isDense: true,
                      decoration: textInputdec,
                      // validator: (val)=> val!.isEmpty ? 'Select sugar amount' : null,
                      // onSaved: (val) {
                      //   setState(() {
                      //     _currentSugars = val.toString();
                      //   });
                      // },
                      onChanged: (val) {
                        setState(() {
                          _currentSugars = val.toString();
                        });
                      },
                      hint: const Text('-SELECT-'),
                      value: _currentSugars ?? userData.sugar,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          child: Text('$sugar Sugars'),
                          value: sugar,
                        );
                      }).toList(),
                    ),
                    //slider
                    Slider(
                      min: 100,
                      max: 900,
                      divisions: 8,
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      label: (_currentStrength ?? userData.strength).toString(),
                      onChanged: (val) {
                        setState(() {
                          _currentStrength = val.round();
                        });
                      },
                    ),

                    //button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          await Database(uid: user.uid).updateData(
                              _currentSugars ?? userData.sugar,
                              _currentName,
                              _currentStrength ?? userData.strength);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.brown[400]),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                    )
                  ],
                ));
          } else {
            return const Loading();
          }
        });
  }
}
