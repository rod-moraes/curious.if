import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/core.dart';
import '../../../../services/email/email_validator_service.dart';

class FormLoginController {
  final IEmailValidatorService emailValidatorService;
  String? email;
  String? password;

  FormLoginController(this.emailValidatorService);

  void reset() {
    email = null;
    password = null;
  }

  String? validateEmail(String? value) {
    if (!emailValidatorService.validate(value ?? "")) {
      return 'Por favor insira um email válido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if ((value ?? "").length < 6) {
      return 'Por favor insira uma senha válida';
    }
    return null;
  }

  void register() {
    print(email);
    print(password);
    print('aaa');
    Modular.to.navigate("../${AppRoutes.signup}/",
        arguments: {"email": email, "password": password});
    email = null;
    password = null;
  }

  void savedEmail(String? value) => email = value;

  void savedPassword(String? value) => password = value;

  void printDados() {
    print(email);
    print(password);
  }
}
