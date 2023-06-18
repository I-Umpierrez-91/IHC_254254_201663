import 'package:invenflow_app/models/user.dart';
import 'package:invenflow_app/repositories/auth/auth_dataprovider.dart';

class AuthRepository {
  final AuthDataProvider _authDataProvider;

  AuthRepository({required AuthDataProvider dataProvider})
      : _authDataProvider = dataProvider;

  Future insertUser(User? user) async {
    return await _authDataProvider.insertUser(user);
  }
}
