import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:invenflow_app/models/user.dart';
import 'package:invenflow_app/models/session.dart';

import '../../common/tockenManager.dart';

class AuthDataProvider {
  static const URL =
      // android emulator usar 10.0.2.2
      // dispositivo real usar IP
      "http://192.168.1.50:8000/api/v1";

  Future<int> insertUser(User? user) async {
    final url = Uri.parse('${URL}/auth/company-signup');
    final body = jsonEncode({"adminData": user?.toJson()});

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      final userId = jsonResponse["userId"] as int;
      print('User created sucessfully. This is the userId created: ${userId}');
      return userId;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      throw Exception('Failed to insert user');
    }
  }

  Future<String?> logIn(Session? session) async {
    final url = Uri.parse('${URL}/auth/login');
    final body = jsonEncode(session?.toJson());

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      final token = jsonResponse["token"] as String;
      await TokenManager.saveToken(token);
      String? savedToken = await TokenManager.getToken();
      print("-> savedToken: ${savedToken}");
      return savedToken;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      throw Exception('Failed to insert user');
    }
  }
}
