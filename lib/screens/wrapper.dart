//import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
//import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user5 = Provider.of<Users?>(context);
    // print('user$user5');
    if (user5 == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
