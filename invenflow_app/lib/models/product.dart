class Product {
  int? id;
  String name;
  String description;
  int price;
  int? stock;
  String? qrCode;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.stock,
    this.qrCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'qrCode': qrCode,
    };
  }
}
