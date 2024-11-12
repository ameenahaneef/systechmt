import 'dart:convert';

import 'package:systechmt/core/constants/api_endpoints.dart';
import 'package:systechmt/data/models/model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Student>> getDetails() async {
    final url = Uri.parse(ApiEndpoints.getUrl);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> students = jsonDecode(response.body);
        return students.map((json) => Student.fromJson(json)).toList();
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception('error$e');
    }
  }

  Future<void> loginUser(
      {required String userName,
      required String password,
      int expiresInMins = 30}) async {
    final url = Uri.parse(ApiEndpoints.loginUrl);
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": "emilys",
          "password": "emilyspass",
          "expiresInMins": expiresInMins
        }),
      );

      if (response.statusCode == 200) {
        print("Login successful: ${response.body}");
      } else {}
    } catch (e) {
      throw Exception('$e');
    }
  }
}
