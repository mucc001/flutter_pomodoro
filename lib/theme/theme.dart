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

TextTheme getCustomTextTheme(BuildContext context, String fontSelection) {
  final baseTheme = Theme.of(context).textTheme;

  TextTheme Function(TextTheme) selectedFontTheme;

  switch (fontSelection) {
    case 'Kumbh Sans':
      selectedFontTheme = GoogleFonts.kumbhSansTextTheme;
      break;
    case 'Roboto Slab':
      selectedFontTheme = GoogleFonts.robotoSlabTextTheme;
      break;
    case 'Space Mono':
      selectedFontTheme = GoogleFonts.spaceMonoTextTheme;
      break;
    default:
      selectedFontTheme = GoogleFonts.kumbhSansTextTheme;
  }

  return selectedFontTheme(baseTheme);
}
