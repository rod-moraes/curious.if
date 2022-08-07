import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  TextStyle get titleLarge;
  TextStyle get headlineMedium;
  TextStyle get labelMedium;
  TextStyle get labelLarge;

  TextStyle get titleLargeBold;
  TextStyle get headlineMediumBold;
  TextStyle get labelMediumBold;
  TextStyle get labelLargeBold;

  TextStyle get titleLargeSemiBold;
  TextStyle get headlineMediumSemiBold;
  TextStyle get labelMediumSemiBold;
  TextStyle get labelLargeSemiBold;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get labelMedium => GoogleFonts.poppins(
        fontSize: 14,
        height: 21 / 24,
        fontWeight: FontWeight.normal,
      );

  @override
  TextStyle get labelLarge => GoogleFonts.poppins(
        fontSize: 18,
        height: 21 / 24,
        fontWeight: FontWeight.normal,
      );

  @override
  TextStyle get titleLarge => GoogleFonts.poppins(
        fontSize: 24,
        height: 36 / 24,
        fontWeight: FontWeight.normal,
      );
  @override
  TextStyle get headlineMedium => GoogleFonts.poppins(
        fontSize: 30,
        height: 45 / 30,
        fontWeight: FontWeight.normal,
      );

  @override
  TextStyle get titleLargeBold =>
      titleLarge.copyWith(fontWeight: FontWeight.bold);

  @override
  TextStyle get headlineMediumBold =>
      headlineMedium.copyWith(fontWeight: FontWeight.bold);

  @override
  TextStyle get labelMediumBold =>
      labelMedium.copyWith(fontWeight: FontWeight.bold);

  @override
  TextStyle get labelLargeBold =>
      labelLarge.copyWith(fontWeight: FontWeight.bold);

  @override
  TextStyle get titleLargeSemiBold =>
      titleLarge.copyWith(fontWeight: FontWeight.w600);

  @override
  TextStyle get headlineMediumSemiBold =>
      headlineMedium.copyWith(fontWeight: FontWeight.w600);

  @override
  TextStyle get labelMediumSemiBold =>
      labelMedium.copyWith(fontWeight: FontWeight.w600);

  @override
  TextStyle get labelLargeSemiBold =>
      labelLarge.copyWith(fontWeight: FontWeight.w600);
}
