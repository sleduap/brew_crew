import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';

class Database {
  String uid;
  Database({
    required this.uid,
  });

  ///collection reference
  ///collection refrence is use to add delete update user data
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateData(String sugar, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'Sugar': sugar, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Brew(
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 100,
          sugar: doc.get('Sugar') ?? '0');
    }).toList();
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        strength: snapshot.get('strength'),
        sugar: snapshot.get('Sugar'));
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}







 // List<Brew> _brewlistFromSnapshot (QuerySnapshot snapshot){
  //   return snapshot.docs.map((e){
  //     return Brew(sugar: e.data['sugar']??'', name: e.data['name']??'', strength: e.data['strength']??0);
  //   });
  // }
  // brew list from snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     //print(doc.data);
  //     return Brew(
  //         name: doc.get('name') ?? '',
  //         strength: doc.get('strength') ?? 0,
  //         sugar: doc.get('sugar') ?? '0');
  //   }).toList();
  // }

  // Stream<List<Brew>?> get brews {
  //   return brewCollection.snapshots().map(_brewListFromSnapshot);
  // }
