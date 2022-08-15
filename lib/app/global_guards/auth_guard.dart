// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter_modular/flutter_modular.dart';

import '../app_routes.dart';
import '../global_store/user/user_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/${AppRoutes.notAuth}');

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    return Modular.get<UserStore>().isLogged;
  }
}
