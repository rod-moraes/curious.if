import 'dart:math';

import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';
import '../../../shared/snack_bar_info/snack_bar_info.dart';
import '../../core/core.dart';
import '../../domain/signup/model/sign_up_model.dart';
import 'sign_up_store.dart';
import 'widgets/form_sign_up/form_sign_up.dart';

class SignUpPage extends StatefulWidget {
  final String initialEmail;
  final String initialPassword;
  const SignUpPage({
    Key? key,
    this.initialEmail = '',
    this.initialPassword = '',
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final store = Modular.get<SignUpStore>();
  final storeTheme = Modular.get<ThemeStore>();

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
  void initState() {
    store.autoRun(showSnackBar);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: storeTheme.colorStatus,
      sized: false,
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            reverse: true,
            children: [
              AnimatedContainer(
                height: isKeyboard ? 25 : 70,
                constraints: BoxConstraints(maxHeight: height(7)),
                duration: const Duration(milliseconds: 150),
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.linear,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: max(width(14), width(50) - 400)),
                child: Image.asset(AppTheme.images.logo),
              ),
              AnimatedContainer(
                height: isKeyboard ? 25 : 95,
                constraints: BoxConstraints(maxHeight: height(7)),
                duration: const Duration(milliseconds: 150),
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.linear,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(11)),
                child: Column(
                  children: [
                    Text(
                      "Crie sua conta",
                      style: AppTheme.textStyles.titleLarge,
                    ),
                    AnimatedContainer(
                      height: isKeyboard ? 25 : 48,
                      constraints: BoxConstraints(maxHeight: height(7)),
                      duration: const Duration(milliseconds: 150),
                      // Provide an optional curve to make the animation feel smoother.
                      curve: Curves.linear,
                    ),
                    FormSignUpWidget(
                      initialEmail: widget.initialEmail,
                      initialPassword: widget.initialPassword,
                      onSaved: (signUpMap) async => await store.signUp(
                        signUpModel: SignUpModel.fromMap(signUpMap),
                      ),
                    ),
                  ],
                ),
              ),
            ].reversed.toList(),
          ),
        ),
        bottomNavigationBar: BottomTextNavigationBar(
          icon: Icons.arrow_back,
          onTap: () => Modular.to.navigate('/${AppRoutes.auth}/', arguments: {
            'email': widget.initialEmail,
          }),
          text: "Voltar para o login",
        ),
      ),
    );
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }
}
