import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:invenflow_app/models/purchase.dart';


import '../../common/tockenManager.dart';

class PurchasesDataProvider {
  final URL = dotenv.env['BACKEND_URL'] ?? "missing backend url";

  Future<int> postSale(Purchase purchase) async {
    final url = Uri.parse('$URL/purchases');
    final body = jsonEncode(purchase?.toJson());

    final currentToken = await TokenManager.getToken();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $currentToken'
      },
      body: body,
    );
    print("Compra ${response.body} creada");

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      throw Exception('Failed to create purchase');
    }
  }
}
