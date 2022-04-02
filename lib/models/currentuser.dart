class CurrentUser {
  final String uid;

  CurrentUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final int price;
  UserData({required this.uid, required this.name, required this.price});
}
