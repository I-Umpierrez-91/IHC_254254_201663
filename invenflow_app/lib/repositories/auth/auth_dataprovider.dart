import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:invenflow_app/models/user.dart';

class AuthDataProvider {
  static const URL =
      "http://api-gateway-prod-alb-2091094697.us-east-1.elb.amazonaws.com/api/v1";

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
      final userId = jsonResponse["user"] as int;
      print('User created sucessfully. This is the userId created: ${userId}');
      return userId;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      throw Exception('Failed to insert user');
    }
  }
}
