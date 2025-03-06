import 'dart:convert';

class Post {
  final String id;
  final String userId;
  final String? photo;
  final String? video;
  final String description;
  final List<String> likes;
  final List<Comment> comments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Post({
    required this.id,
    required this.userId,
    this.photo,
    this.video,
    required this.description,
    required this.likes,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      userId: json['user_id'],
      photo: json['photo'],
      video: json['video'],
      description: json['description'],
      likes: List<String>.from(json['likes'] ?? []),
      comments: (json['comments'] as List<dynamic>?)
              ?.map((c) => Comment.fromJson(c))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'photo': photo,
      'video': video,
      'description': description,
      'likes': likes,
      'comments': comments.map((c) => c.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

class Comment {
  final String userId;
  final String text;
  final String id;
  final DateTime createdAt;

  Comment({
    required this.userId,
    required this.text,
    required this.id,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['user_id'],
      text: json['text'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'text': text,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
