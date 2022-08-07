import 'package:curious_if/app/domain/signup/repository/sign_up_repository.dart';
import 'package:curious_if/app/domain/signup/usecase/sign_up_usecase.dart';
import 'package:curious_if/app/modules/sign_up/sign_up_page.dart';
import 'package:curious_if/app/modules/sign_up/sign_up_success/sign_up_success_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'sign_up_store.dart';

class SignUpModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => SignUpRepository(i())),
    Bind.factory((i) => SignUpUseCase(i())),
    Bind.lazySingleton<SignUpStore>((i) => SignUpStore(i()),
        onDispose: (bloc) => bloc.dispose()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => SignUpPage(
          initialEmail: args.data?['email'] ?? '',
          initialPassword: args.data?['password'] ?? ''),
    ),
    ChildRoute('/success',
        child: (_, args) =>
            SignUpSuccessPage(email: args.data?['email'] ?? '')),
  ];
}
