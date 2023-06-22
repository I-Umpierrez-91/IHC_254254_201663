import 'package:invenflow_app/repositories/product/product_dataprovider.dart';

class ProductRepository {
  final ProductDataProvider _productDataProvider;

  ProductRepository({required ProductDataProvider dataProvider})
      : _productDataProvider = dataProvider;

  Future getProducts() async {
    return await _productDataProvider.getProducts();
  }
}
