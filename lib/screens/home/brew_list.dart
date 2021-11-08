import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    // print(brews);
    // if (brews != null) {
    //   brews.forEach((brew) {
    //     print(brew.name);
    //     print(brew.sugar);
    //   });
    // }

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
        // return const Padding(
        //   padding: EdgeInsets.symmetric(
        //     vertical: 9,
        //     horizontal: 9,
        //   ),
        //   child: Card(
        //     child: ListTile( ),
        //   ),
        // );
      },
    );
  }
}
