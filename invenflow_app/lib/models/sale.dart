import 'package:invenflow_app/models/order_detail.dart';

class Sale {
  int? id;
  int client = 1;
  DateTime saleDate = DateTime.now();
  List<OrderDetail> orderDetails = [];

  Sale({
    this.id,
    required this.client,
    required this.saleDate,
    required this.orderDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'client': client,
      'saleDate': saleDate,
      'saleDetails': orderDetails,
    };
  }
}
