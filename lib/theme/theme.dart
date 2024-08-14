import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primaryRed = Color(0xFFF87070);
  static const primaryBlue = Color(0xFF70F3F8);
  static const primaryPurple = Color(0xFFDB81F8);
  static const backgroundDark = Color(0xFF1E213F);
  static const overlayDark = Color(0xFF161932);
  static const textWhite = Color(0xFFFFFFFF);
  static const textLight = Color(0xFFEFF1FA);
  static const textFill = Color(0xFFD7E0FF);
  static const textDark = Color(0xFF1E213F);
  static const buttonApply = Color(0xFFF87070);
  static const buttonFill = Color(0xFFEFF1FA);
}

class DynamicTextStyles {
  final String fontFamily;
  final Color fontColor;

  DynamicTextStyles(this.fontFamily, this.fontColor);

  TextStyle getH1({color = AppColors.textWhite, fontFamily = 'Kumbh Sans'}) {
    return _getTextStyle(
      fontSize: 100,
      fontWeight: FontWeight.bold,
      color: color,
      lineHeight: 120,
      letterSpacing: -5,
      fontFamily: fontFamily,
    );
  }

  TextStyle getH2({color = AppColors.textWhite, fontFamily = 'Kumbh Sans'}) {
    return _getTextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: color,
      lineHeight: 34,
      fontFamily: fontFamily,
    );
  }

  TextStyle getH3({color = AppColors.textWhite, fontFamily = 'Kumbh Sans'}) {
    return _getTextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: color,
      lineHeight: 19,
      letterSpacing: 15,
      fontFamily: fontFamily,
    );
  }

  TextStyle getH4({color = AppColors.textWhite, fontFamily = 'Kumbh Sans'}) {
    return _getTextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: color,
      lineHeight: 16,
      letterSpacing: 5,
      fontFamily: fontFamily,
    );
  }

  TextStyle getBody1({color = AppColors.textWhite, fontFamily = 'Kumbh Sans'}) {
    return _getTextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: color,
      lineHeight: 18,
      fontFamily: fontFamily,
    );
  }

  TextStyle getBody2({color = AppColors.textWhite, fontFamily = 'Kumbh Sans'}) {
    return _getTextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: color,
      lineHeight: 14,
      fontFamily: fontFamily,
    );
  }

  TextStyle _getTextStyle({
    required double fontSize,
    required Color color,
    required double lineHeight,
    required String fontFamily,
    double? letterSpacing,
    FontWeight? fontWeight,
  }) {
    final TextStyle textStyle;

    switch (fontFamily) {
      case 'Kumbh Sans':
        textStyle = GoogleFonts.kumbhSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: lineHeight / fontSize,
          letterSpacing: letterSpacing,
        );
      case 'Roboto Slab':
        textStyle = GoogleFonts.robotoSlab(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: lineHeight / fontSize,
          letterSpacing: letterSpacing,
        );
      case 'Space Mono':
        textStyle = GoogleFonts.spaceMono(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: lineHeight / fontSize,
          letterSpacing: letterSpacing,
        );
      default:
        throw ArgumentError('Invalid font family: $fontFamily');
    }
    return textStyle;
  }
}
