import 'package:invenflow_app/models/product.dart';

class OrderDetail {
  int? id;
  Product product;
  int subtotal;
  int? quantity;

  OrderDetail({
    this.id,
    required this.product,
    required this.subtotal,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': product.id,
      'quantity': quantity,
    };
  }
}
