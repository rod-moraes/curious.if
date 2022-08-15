import 'package:flutter/material.dart';

abstract class AppColors {
  Color get colorSchemeSeed;
  Color get background;
  Color get colorShimmer;
  Color get colorSecondaryShimmer;
}

class AppColorsLight implements AppColors {
  @override
  Color get colorSchemeSeed => const Color(0xff05A678);

  @override
  Color get background => const Color(0xfffbfdf9);

  @override
  Color get colorShimmer => const Color(0x5f3f3f3f);

  @override
  Color get colorSecondaryShimmer => const Color(0xffaaa4a4);
}

class AppColorsDark implements AppColors {
  @override
  Color get colorSchemeSeed => const Color(0xff05A678);

  @override
  Color get background => const Color(0xff3E3B47);

  @override
  Color get colorShimmer => const Color(0x3ff3f3f3);

  @override
  Color get colorSecondaryShimmer => const Color(0x0f4a4a4a);
}
