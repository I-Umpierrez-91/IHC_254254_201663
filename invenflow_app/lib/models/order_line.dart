class OrderDetail {
  int? id;
  int productId;
  int price;
  int? quantity;

  OrderDetail({
    this.id,
    required this.productId,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'price': price,
      'quantity': quantity,
    };
  }
}
