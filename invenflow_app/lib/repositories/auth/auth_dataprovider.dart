import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:invenflow_app/models/user.dart';
import 'package:invenflow_app/models/session.dart';

import '../../common/tockenManager.dart';

class AuthDataProvider {
  final URL = dotenv.env['BACKEND_URL'] ?? "missing backend url";

  Future<int> insertUser(User? user) async {
    final url = Uri.parse('$URL/auth/company-signup');
    final body = jsonEncode({"adminData": user?.toJson()});

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      final userId = jsonResponse["userId"] as int;
      print('User created sucessfully. This is the userId created: $userId');
      return userId;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      return -1;
    }
  }

  Future<String?> logIn(Session? session) async {
    final url = Uri.parse('$URL/auth/login');
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
      print("-> savedToken: $savedToken");
      return savedToken;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      throw Exception('Failed to insert user');
    }
  }
}
