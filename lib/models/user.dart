class AppUser {
  final String uid;

  AppUser({required this.uid});
}

class AppUserData {
  final String? uid;
  final String? name;
  final String? sugars;
  final int? strength;

  AppUserData({this.uid, this.name, this.sugars, this.strength});
}
