class Users {
  final uid;
  Users({
    required this.uid,
  });
}

class UserData {
  final String sugar;
  final String name;
  final int strength;
  final String uid;

  UserData(
      {required this.sugar,
      required this.name,
      required this.strength,
      required this.uid});
}
