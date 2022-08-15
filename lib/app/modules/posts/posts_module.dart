import 'package:curious_if/app/modules/posts/posts_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/post/repository/post_repository.dart';
import '../../domain/post/usecase/post_usecase.dart';
import '../../domain/reports/repository/reports_repository.dart';
import '../../domain/reports/usecase/reports_usecase.dart';
import 'posts_store.dart';

class PostsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => PostRepository(datasource: i())),
    Bind.factory((i) => ReportsRepository(datasource: i())),
    Bind.factory((i) => PostUseCase(repository: i())),
    Bind.factory((i) => ReportsUseCase(repository: i())),
    Bind.lazySingleton<PostsStore>(
        (i) =>
            PostsStore(postUsecase: i(), reportUsecase: i(), storePosts: i()),
        onDispose: (bloc) => bloc.dispose()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => PostsPage(),
      transition: TransitionType.rightToLeft,
    ),
  ];
}
