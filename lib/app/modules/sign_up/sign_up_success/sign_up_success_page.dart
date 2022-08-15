import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sizer/sizer.dart';
import '../../../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';
import '../../../../shared/button_form_input/button_form_input.dart';
import '../../../core/core.dart';

class SignUpSuccessPage extends StatelessWidget {
  final String email;
  const SignUpSuccessPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeTheme = Modular.get<ThemeStore>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: storeTheme.colorStatus,
      sized: false,
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 11.w),
              child: Column(
                children: [
                  SizedBox(height: 17.5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: Image.asset(AppTheme.images.checkIcon,
                        fit: BoxFit.fitWidth),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "Cadastro concluído",
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Text(
                          "Aguarde até que um moderador aprove seu cadastro",
                          style: AppTheme.textStyles.labelMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  ButtonFormInput(
                    text: "Saquei!",
                    onTap: () async => Modular.to.navigate(
                      "/${AppRoutes.auth}/",
                      arguments: {"email": email},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomTextNavigationBar(
          icon: Icons.arrow_back,
          onTap: () => Modular.to.navigate("./"),
          text: "Voltar para o cadastro",
        ),
      ),
    );
  }
}
