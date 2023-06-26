import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:invenflow_app/models/product.dart';

import '../../common/tockenManager.dart';

class ProductDataProvider {
  final URL = dotenv.env['BACKEND_URL'] ?? "missing backend url";

  Future<List<Product>> getProducts() async {
    final url = Uri.parse('$URL/products');
    final currentToken = await TokenManager.getToken();

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $currentToken'},
    );
    print("1${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      print("2 $jsonResponse");
      final List<Product> products = jsonResponse.map((item) {
        return Product(
          id: item['id'],
          name: item['name'],
          description: item['description'],
          price: item['price'],
          stock: item['stock'],
          qrCode: item['qrCode'],
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

  Future<Product> createProduct(Product? product) async {
    final url = Uri.parse('$URL/products');
    final body = jsonEncode(product?.toJson());
    final currentToken = await TokenManager.getToken();

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $currentToken'
      },
      body: body,
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      final product = Product(
        id: jsonResponse['id'],
        name: jsonResponse['name'],
        description: jsonResponse['description'],
        qrCode: jsonResponse['qrCode'],
        price: jsonResponse['price'],
        stock: jsonResponse['stock'],
      );
      return product;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      throw Exception('Failed to create product');
    }
  }

  Future<Product> getProduct(String productId) async {
    final url = Uri.parse('$URL/products/$productId');
    final currentToken = await TokenManager.getToken();

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $currentToken'
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final product = Product(
        id: jsonResponse['id'],
        name: jsonResponse['name'],
        description: jsonResponse['description'],
        qrCode: jsonResponse['qrCode'],
        price: jsonResponse['price'],
        stock: jsonResponse['stock'],
      );
      return product;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      throw Exception('Failed to get product');
    }
  }
}
