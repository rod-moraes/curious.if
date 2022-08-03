import 'package:curious_if/app/services/client/client_service.dart';

import '../../../core/core.dart';
import '../model/auth_model.dart';
import '../model/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> auth(AuthModel authModel);
  void dispose();
}

class AuthRepository implements IAuthRepository {
  final ClientService _datasource;
  final String server = UtilsConst.server;

  AuthRepository(ClientService datasource) : _datasource = datasource;

  @override
  Future<UserModel> auth(AuthModel authModel) async {
    try {
      String response = await _datasource.post(
        Uri.parse("${server}api/auth/login/"),
      );
      UserModel userModel = UserModel.fromJson(response);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _datasource.dispose();
  }
}
