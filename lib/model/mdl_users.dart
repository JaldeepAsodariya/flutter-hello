import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_hello/config/api_config.dart';
import 'package:flutter_hello/model/mdl_address.dart';
import 'package:http/http.dart' as http;

Future<List<MdlUsers>> fetchUsers() async {
  final response = await http.Client().get(API_ROOT_URL + FUNCTION_USERS);

  // Use the compute function to run parseUsers in a separate isolate
  return compute(parseUsers, response.body);
}

// A function that will convert a response body into a List<User>
List<MdlUsers> parseUsers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<MdlUsers>((json) => MdlUsers.fromJson(json)).toList();
}

class MdlUsers {
  final int id;
  final String name;
  final String email;
  final MdlAddress address;

  MdlUsers({this.id, this.name, this.email, this.address});

  factory MdlUsers.fromJson(Map<String, dynamic> json) {
    return MdlUsers(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      address: MdlAddress.fromJson(json['address']),
    );
  }
}