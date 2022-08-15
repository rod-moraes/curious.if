import 'package:flutter_modular/flutter_modular.dart';
import '../../domain/auth/repository/auth_repository.dart';
import '../../domain/auth/usecase/auth_usecase.dart';
import '../../services/email/email_validator_service.dart';
import 'auth_page.dart';
import 'auth_store.dart';
import 'widgets/form_login/form_login_controller.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => AuthRepository(i())),
    Bind.factory((i) => AuthUseCase(i())),
    Bind.factory((i) => EmailValidatorService()),
    Bind.singleton<AuthStore>((i) => AuthStore(i()),
        onDispose: (bloc) => bloc.dispose()),
    Bind.singleton((i) => FormLoginController(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, args) {
      String email = (args.data is Map) ? (args.data?["email"] ?? '') : '';
      return AuthPage(email: email);
    }),
  ];
}
