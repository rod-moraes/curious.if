import '../model/auth_model.dart';
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
