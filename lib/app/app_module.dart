import 'package:flutter_modular/flutter_modular.dart';

import 'core/core.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';
import 'services/client/client_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HttpClient()),
    Bind.singleton((i) => ThemeStore())
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
  ];
}
