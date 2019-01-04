import 'dart:convert';

class MdlPostsReq {
  String title, body, userId;
}

Map<String, String> requestJsonMap(String titleVal, bodyVal, userIdVal) {
  Map<String, String> generateJsonMap = {
    'title': titleVal,
    'body': bodyVal,
    'userId': userIdVal,
  };

  return generateJsonMap;
}

// A function that will convert a response body into a MdlPosts
MdlPostsRes mdlPostsFromJson(String responseBody) {
  final parsed = json.decode(responseBody);
  return MdlPostsRes.fromJson(parsed);
}

class MdlPostsRes {
  final int id;
  final String title;
  final String body;
  final String userId;

  MdlPostsRes({this.id, this.title, this.body, this.userId});

  factory MdlPostsRes.fromJson(Map<String, dynamic> json) => new MdlPostsRes(
    id: json['id'] as int,
    title: json['title'] as String,
    body: json['body'] as String,
    userId: json['userId'] as String,
  );
}
