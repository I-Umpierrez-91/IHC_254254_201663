import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:invenflow_app/models/product.dart';

import '../../common/tockenManager.dart';

class ProductDataProvider {
  static const URL = "http://192.168.1.50:8000/api/v1";

  Future<List<Product>> getProducts() async {
    final url = Uri.parse('${URL}/products');
    final currentToken = await TokenManager.getToken();

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${currentToken}'},
    );
    print("1" + response.body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      print("2 ${jsonResponse}");
      final List<Product> products = jsonResponse.map((item) {
        return Product(
          name: item['name'],
          description: item['description'],
          image: item['image'],
          price: item['price'],
          stock: item['stock'],
        );
      }).toList();

      print("3");
      print(products);
      return products;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      throw Exception('Failed to get products');
    }
  }
}
