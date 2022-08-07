import 'package:curious_if/app/services/local_preferences/local_preferences_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'modules/auth/auth_module.dart';
import 'modules/sign_up/sign_up_module.dart';
import 'services/client/client_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance()),
    Bind.factory((i) => SharedPreferencesService(instance: i())),
    Bind.lazySingleton<ThemeStore>(
      (i) => ThemeStore(instance: i()),
      onDispose: (bloc) => bloc.dispose(),
    ),
    Bind.factory<ClientService>((i) => HttpClient()),
  ];

  @override
  final List<ModularRoute> routes = [
    RedirectRoute("/", to: "/${AppRoutes.auth}/"),
    ModuleRoute("/${AppRoutes.auth}/", module: AuthModule()),
    ModuleRoute("/${AppRoutes.signup}", module: SignUpModule()),
  ];
}
