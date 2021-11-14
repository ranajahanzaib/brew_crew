class AppUser {
  final String uid;

  AppUser({required this.uid});
}

class AppUserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  AppUserData(
      {required this.uid,
      required this.name,
      required this.sugars,
      required this.strength});
}
