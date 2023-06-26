import 'package:invenflow_app/models/order_detail.dart';

class Sale {
  int? id;
  int client = 1;
  DateTime saleDate = DateTime.now();
  List<OrderDetail> orderDetails = [];
  double longitude = 0;
  double latitude = 0;

  Sale({
    this.id,
    required this.client,
    required this.saleDate,
    required this.orderDetails,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'client': client,
      'saleDate': saleDate.toIso8601String(),
      'saleDetails': orderDetails.map((e) => e.toJson()).toList(),
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
