import 'package:curious_if/app/core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpSuccessController {
  void navigationLogin(String email) {
    print(email);
    Modular.to.navigate(
      "/${AppRoutes.auth}/",
      arguments: {"email": email},
    );
  }
}
