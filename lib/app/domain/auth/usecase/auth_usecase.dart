import '../model/auth_model.dart';
import '../model/roles_permission_model.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';

abstract class IAuthUseCase {
  Future<UserModel> auth(AuthModel authModel);
  void dispose();
}

class AuthUseCase implements IAuthUseCase {
  final IAuthRepository _repository;

  AuthUseCase(IAuthRepository repository) : _repository = repository;

  @override
  Future<UserModel> auth(AuthModel authModel) async {
    try {
      // UserModel user = UserModel(
      //   email: authModel.email,
      //   id: "1",
      //   name: "Rodrigo",
      //   permissions: [Permission.canPost],
      //   roles: [Roles.admin],
      //   token: "1",
      // );
      UserModel user = await _repository.auth(authModel);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
