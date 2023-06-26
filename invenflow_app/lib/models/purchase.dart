import 'package:invenflow_app/models/order_detail.dart';

class Purchase {
  int? id;
  int provider = 1;
  List<OrderDetail> orderDetails = [];
  double longitude = 0;
  double latitude = 0;

  Purchase({
    this.id,
    required this.provider,
    required this.orderDetails,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'purchaseDetails': orderDetails.map((e) => e.toJson()).toList(),
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
