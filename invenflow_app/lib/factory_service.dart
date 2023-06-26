import 'package:invenflow_app/repositories/auth/auth_dataprovider.dart';
import 'package:invenflow_app/repositories/auth/auth_repository.dart';
import 'package:invenflow_app/repositories/product/product_dataprovider.dart';
import 'package:invenflow_app/repositories/product/product_repository.dart';
import 'package:invenflow_app/repositories/purchases/purchases_dataprovider.dart';
import 'package:invenflow_app/repositories/purchases/sales_repository.dart';
import 'package:invenflow_app/repositories/sales/sales_dataprovider.dart';
import 'package:invenflow_app/repositories/sales/sales_repository.dart';

class FactoryServices {
  static FactoryServices? _instance;

  AuthRepository? _authRepository;
  ProductRepository? _productRepository;
  SalesRepository? _salesRepository;
  PurchasesRepository? _purchasesRepository;

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

  SalesRepository getSalesService() {
    _salesRepository = SalesRepository(dataProvider: SalesDataProvider());
    return _salesRepository!;
  }

  PurchasesRepository getPurchasesService() {
    _purchasesRepository = PurchasesRepository(dataProvider: PurchasesDataProvider());
    return _purchasesRepository!;
  }
}
