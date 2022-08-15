import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sizer/sizer.dart';
import '../../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';
import '../../../shared/button_form_input/button_form_input.dart';
import '../../core/core.dart';

class AccountNotLoggedPage extends StatefulWidget {
  const AccountNotLoggedPage({Key? key}) : super(key: key);

  @override
  State<AccountNotLoggedPage> createState() => _AccountNotLoggedPageState();
}

class _AccountNotLoggedPageState extends State<AccountNotLoggedPage> {
  final storeTheme = Modular.get<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: storeTheme.colorStatus,
      sized: false,
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 24),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Icon(
                      Icons.account_circle_sharp,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    "Opa!",
                    style: AppTheme.textStyles.headlineMediumSemiBold,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Você ainda não fez login!",
                    style: AppTheme.textStyles.labelMedium.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              ButtonFormInput(
                  onTap: () async {
                    Modular.to.navigate("/${AppRoutes.auth}/");
                  },
                  text: "Fazer login"),
              SizedBox(height: 8),
            ],
          ),
        ),
        bottomNavigationBar: BottomTextNavigationBar(
          icon: Icons.arrow_back,
          onTap: () => Modular.to.navigate("/posts/"),
          text: "Voltar para a home",
        ),
      ),
    );
  }
}
