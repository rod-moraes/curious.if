import 'package:flutter/material.dart';

abstract class AppColors {
  Color get colorSchemeSeed;
  Color get background;
}

class AppColorsLight implements AppColors {
  @override
  Color get colorSchemeSeed => const Color(0xff006C4D);

  @override
  Color get background => const Color(0xfffbfdf9);
}

class AppColorsDark implements AppColors {
  @override
  Color get colorSchemeSeed => const Color(0xff006C4D);

  @override
  Color get background => const Color(0xff3E3B47);
}
