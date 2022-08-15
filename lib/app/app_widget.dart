import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sizer/sizer.dart';

import 'app_module.dart';
import 'core/core.dart';
import 'core/theme/color_scheme.g.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final Future<void> future;
  late final ThemeStore themeStore;
  Future<void> frameFuture() async {
    await Modular.isModuleReady<AppModule>();
    themeStore = Modular.get<ThemeStore>();
    themeStore.listenBrightnessSystem();
    await themeStore.currentThemeMode();
  }

  @override
  void initState() {
    future = frameFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("Uaia");
            Modular.to.addListener(() {
              print("Uai");
              debugPrint(Modular.to.path);
            });
            Modular.setObservers([Asuka.asukaHeroController]);
            return Sizer(builder: (_, __, ___) {
              return Observer(builder: (context) {
                return MaterialApp.router(
                  builder: Asuka.builder,
                  title: 'Curious.IF',
                  themeMode: themeStore.themeMode,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    colorScheme: lightColorScheme,
                    useMaterial3: true,
                    backgroundColor: lightColorScheme.background,
                    scaffoldBackgroundColor: lightColorScheme.background,
                  ),
                  darkTheme: ThemeData(
                    colorScheme: darkColorScheme,
                    useMaterial3: true,
                    brightness: Brightness.dark,
                    backgroundColor: darkColorScheme.background,
                    scaffoldBackgroundColor: darkColorScheme.background,
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
