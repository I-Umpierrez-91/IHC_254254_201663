class Product {
  int? id;
  String name;
  String description;
  String? image;
  int price;
  int? stock;

  Product({
    this.id,
    required this.name,
    required this.description,
    this.image,
    required this.price,
    this.stock,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'stock': stock,
    };
  }
}
