import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sizer/sizer.dart';
import '../../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';
import '../../core/core.dart';
import '../../domain/auth/model/auth_model.dart';
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
  @override
  void initState() {
    super.initState();
  }

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
                constraints: BoxConstraints(maxHeight: 7.h),
                duration: const Duration(milliseconds: 150),
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.linear,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Image.asset(AppTheme.images.logo),
              ),
              AnimatedContainer(
                height: isKeyboard ? 32 : 95,
                constraints: BoxConstraints(maxHeight: 5.h * 100.h / 100.w),
                duration: const Duration(milliseconds: 150),
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.linear,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.w),
                child: Column(
                  children: [
                    Text("Login"),
                    AnimatedContainer(
                      height: isKeyboard ? 24 : 48,
                      constraints:
                          BoxConstraints(maxHeight: 5.h * 100.h / 100.w),
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
          icon: Icon(Icons.arrow_back, size: 18),
          onTap: () => Navigator.pop(context),
          text: "Voltar para a home",
        ),
      ),
    );
  }
}
