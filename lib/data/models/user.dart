import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String password;
  List<int> bookmarksIds;

  User({
    required this.name,
    required this.email,
    required this.password,
    this.bookmarksIds = const [],
    this.id = 0,
  });

  String toJson() {
    return jsonEncode({"name": name, "email": email, "password": password, "bookmarksIds": bookmarksIds, "id": id});
  }

  User.fromJson(Map<String, dynamic> map)
    : name = map['name'],
      email = map['email'],
      password = map['password'],
      bookmarksIds = List<int>.from(map['bookmarksIds']),
      id = map['id'];
}
