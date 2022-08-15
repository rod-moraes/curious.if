import 'dart:math';

import 'package:asuka/asuka.dart';
import 'package:curious_if/app/modules/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';
import '../../../shared/snack_bar_info/snack_bar_info.dart';
import '../../core/core.dart';
import '../../domain/auth/model/auth_model.dart';
import '../../global_store/user/user_store.dart';
import 'auth_store.dart';
import 'widgets/form_login/form_login.dart';

class AuthPage extends StatefulWidget {
  final String email;
  const AuthPage({
    Key? key,
    this.email = '',
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final store = Modular.get<AuthStore>();
  final storeTheme = Modular.get<ThemeStore>();
  final user = Modular.get<UserStore>();

  @override
  void initState() {
    when(
      (_) => store.state is AuthStateSuccess,
      () => user.login((store.state as AuthStateSuccess).user),
    );
    store.autoRun(showSnackBar);
    super.initState();
  }

  void showSnackBar(String text, bool isError) {
    Asuka
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBarInfo(isError: isError, text: text));
  }

  double height(int porcentagem) =>
      MediaQuery.of(context).size.height * porcentagem / 100;

  double width(int porcentagem) =>
      MediaQuery.of(context).size.width * porcentagem / 100;

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: storeTheme.colorStatus,
      sized: false,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            reverse: true,
            children: [
              AnimatedContainer(
                height: isKeyboard ? 20 : 70,
                constraints: BoxConstraints(maxHeight: height(7)),
                duration: const Duration(milliseconds: 150),
                curve: Curves.linear,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: max(width(14), width(50) - 400)),
                child: Image.asset(
                  AppTheme.images.logo,
                  filterQuality: FilterQuality.high,
                ),
              ),
              AnimatedContainer(
                height: isKeyboard ? 32 : 95,
                constraints: BoxConstraints(maxHeight: height(7)),
                duration: const Duration(milliseconds: 150),
                curve: Curves.linear,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(11)),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: AppTheme.textStyles.titleLarge,
                    ),
                    AnimatedContainer(
                      height: isKeyboard ? 24 : 48,
                      constraints: BoxConstraints(maxHeight: height(7)),
                      duration: const Duration(milliseconds: 150),
                      // Provide an optional curve to make the animation feel smoother.
                      curve: Curves.linear,
                    ),
                    FormLoginWidget(
                      initialEmail: widget.email,
                      onSaved: (loginMap) async => await store.auth(
                          authModel: AuthModel.fromMap(loginMap)),
                    ),
                  ],
                ),
              ),
            ].reversed.toList(),
          ),
        ),
        bottomNavigationBar: BottomTextNavigationBar(
          icon: Icons.arrow_back,
          onTap: () => Modular.to.navigate('/'),
          text: "Voltar para a home",
        ),
      ),
    );
  }
}
