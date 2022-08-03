import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sizer/sizer.dart';

import 'core/core.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final themeStore = Modular.get<ThemeStore>();
  @override
  void initState() {
    themeStore.listenBrightnessSystem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: themeStore.currentThemeMode(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null) {
            return Observer(builder: (context) {
              return Sizer(builder: (_, __, ___) {
                return MaterialApp.router(
                  title: 'Curious.IF',
                  themeMode: themeStore.themeMode,
                  theme: ThemeData(
                    colorSchemeSeed: AppTheme.colors.colorSchemeSeed,
                    useMaterial3: true,
                  ),
                  darkTheme: ThemeData(
                    colorSchemeSeed: AppTheme.colors.colorSchemeSeed,
                    useMaterial3: true,
                    brightness: Brightness.dark,
                  ),
                  routeInformationParser: Modular.routeInformationParser,
                  routerDelegate: Modular.routerDelegate,
                );
              });
            });
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
