import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core.dart';

class AppTheme {
  static AppColors get colors {
    final themeStore = Modular.get<ThemeStore>();
    bool isDarkMode = themeStore.brightness == Brightness.dark;

    if (!isDarkMode) {
      return AppColorsLight();
    } else {
      return AppColorsDark();
    }
  }

  static AppTextStyles get textStyles => AppTextStylesDefault();
  static AppImages get images {
    final themeStore = Modular.get<ThemeStore>();
    bool isDarkMode = themeStore.brightness == Brightness.dark;
    if (!isDarkMode) {
      return AppImagesLight();
    } else {
      return AppImagesDark();
    }
  }
}
