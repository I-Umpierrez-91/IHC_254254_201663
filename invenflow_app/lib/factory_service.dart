import 'package:invenflow_app/repositories/auth/auth_dataprovider.dart';
import 'package:invenflow_app/repositories/auth/auth_repository.dart';

class FactoryServices {
  static FactoryServices? _instance;

  AuthRepository? _authRepository;

  factory FactoryServices() {
    _instance ??= FactoryServices._();
    return _instance!;
  }

  FactoryServices._();

  AuthRepository getAuthService() {
    _authRepository = AuthRepository(dataProvider: AuthDataProvider());
    return _authRepository!;
  }
}
