import 'package:curious_if/app/modules/home/home_page.dart';
import 'package:curious_if/app/modules/posts/posts_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../global_guards/auth_guard.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, args) => const HomePage(), children: [
      ChildRoute(
        '/explorer',
        child: (context, args) => const Text('1'),
        transition: TransitionType.rightToLeft,
        guards: [AuthGuard()],
      ),
      ModuleRoute('/posts', module: PostsModule()),
      ChildRoute(
        '/trending',
        child: (context, args) => const Text('3'),
        transition: TransitionType.rightToLeft,
        guards: [AuthGuard()],
      ),
      ChildRoute(
        '/account',
        child: (context, args) => const Text('4'),
        transition: TransitionType.rightToLeft,
        guards: [AuthGuard()],
      ),
      ChildRoute(
        '/create_post',
        child: (context, args) => const Text('5'),
        transition: TransitionType.rightToLeft,
        guards: [AuthGuard()],
      ),
    ]),
  ];
}
