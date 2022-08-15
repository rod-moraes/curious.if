import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core.dart';
import 'widgets/app_bar_home/app_bar_home.dart';
import 'widgets/bottom_navigation_bar_home/bottom_navigation_bar_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storeTheme = Modular.get<ThemeStore>();
  @override
  void initState() {
    Modular.to.navigate("/posts/");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: storeTheme.colorStatus,
      sized: false,
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        appBar: AppBarHome(
          statusBarHeight: statusBarHeight,
          createPost: () =>
              Modular.to.navigate(BottomNavigationBarEnum.createPage.route),
        ),
        bottomNavigationBar: BottomNavigationBarHome(
          onTap: (index) {
            Modular.to.navigate(index.route);
          },
        ),
        body: RouterOutlet(),
      ),
    );
  }
}
