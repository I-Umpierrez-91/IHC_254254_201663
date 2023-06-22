import 'package:invenflow_app/repositories/auth/auth_dataprovider.dart';
import 'package:invenflow_app/repositories/auth/auth_repository.dart';
import 'package:invenflow_app/repositories/product/product_dataprovider.dart';
import 'package:invenflow_app/repositories/product/product_repository.dart';

class FactoryServices {
  static FactoryServices? _instance;

  AuthRepository? _authRepository;
  ProductRepository? _productRepository;

  factory FactoryServices() {
    _instance ??= FactoryServices._();
    return _instance!;
  }

  FactoryServices._();

  AuthRepository getAuthService() {
    _authRepository = AuthRepository(dataProvider: AuthDataProvider());
    return _authRepository!;
  }

  ProductRepository getProductService() {
    _productRepository = ProductRepository(dataProvider: ProductDataProvider());
    return _productRepository!;
  }
}
