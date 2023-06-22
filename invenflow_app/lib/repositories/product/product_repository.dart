import 'package:invenflow_app/repositories/product/product_dataprovider.dart';

import '../../models/product.dart';

class ProductRepository {
  final ProductDataProvider _productDataProvider;

  ProductRepository({required ProductDataProvider dataProvider})
      : _productDataProvider = dataProvider;

  Future getProducts() async {
    return await _productDataProvider.getProducts();
  }

  Future createProduct(Product? product) async {
    return await _productDataProvider.createProduct(product);
  }
}
