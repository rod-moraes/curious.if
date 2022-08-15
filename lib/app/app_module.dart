import 'package:curious_if/app/global_store/posts/posts_list_store.dart';
import 'package:curious_if/app/modules/home/home_module.dart';
import 'package:curious_if/app/services/local_preferences/local_preferences_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'global_store/user/user_store.dart';
import 'modules/account_not_logged/account_not_logged_page.dart';
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
    Bind.singleton<UserStore>((i) => UserStore()),
    Bind.singleton<PostsListStore>((i) => PostsListStore()),
    Bind.factory<ClientService>((i) => HttpClient()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute("/", module: HomeModule()),
    ChildRoute("/not-auth", child: (_, __) => const AccountNotLoggedPage()),
    ModuleRoute("/${AppRoutes.auth}/", module: AuthModule()),
    ModuleRoute("/${AppRoutes.signup}", module: SignUpModule()),
  ];
}
