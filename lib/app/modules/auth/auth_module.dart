import 'package:curious_if/app/domain/auth/repository/auth_repository.dart';
import 'package:curious_if/app/domain/auth/usecase/auth_usecase.dart';
import 'package:curious_if/app/modules/auth/auth_page.dart';
import 'package:curious_if/app/services/email/email_validator_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'auth_store.dart';
import 'widgets/form_login/form_login_controller.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => AuthRepository(i())),
    Bind.factory((i) => AuthUseCase(i())),
    Bind.factory((i) => EmailValidatorService()),
    Bind.lazySingleton<AuthStore>((i) => AuthStore(i()),
        onDispose: (bloc) => bloc.dispose()),
    Bind.lazySingleton((i) => FormLoginController(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => AuthPage(email: args.data ?? '')),
  ];
}
