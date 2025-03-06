import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final List<String> friends;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.friends,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['_id']?.toString() ?? '',
      username: map['username'] ?? "",
      email: map['email'] ?? "",
      password: map['password'] ?? "",
      friends: List<String>.from(map['friends'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'password': password,
      'friends': friends,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static List<User> fromJsonList(String jsonString) {
    final List<dynamic> data = json.decode(jsonString);
    return data.map((json) => User.fromJson(json)).toList();
  }

  static String toJsonList(List<User> users) {
    final List<Map<String, dynamic>> jsonList =
        users.map((user) => user.toJson()).toList();
    return json.encode(jsonList);
  }
}
