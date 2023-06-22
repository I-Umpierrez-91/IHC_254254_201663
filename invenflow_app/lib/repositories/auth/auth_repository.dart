import 'package:invenflow_app/models/user.dart';
import 'package:invenflow_app/repositories/auth/auth_dataprovider.dart';

import '../../models/session.dart';

class AuthRepository {
  final AuthDataProvider _authDataProvider;

  AuthRepository({required AuthDataProvider dataProvider})
      : _authDataProvider = dataProvider;

  Future insertUser(User? user) async {
    return await _authDataProvider.insertUser(user);
  }

  Future logIn(Session? session) async {
    try {
      return await _authDataProvider.logIn(session);
    } catch (e) {
      return 'false';
    }
  }
}
