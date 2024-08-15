import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/theme/theme.dart';

final colorProvider = StateProvider<int>((ref) => 0);

final tempColorProvider = StateProvider<int>((ref) => 0);

Map<int, Color> colorMap = {
  0: AppColors.primaryRed,
  1: AppColors.primaryBlue,
  2: AppColors.primaryPurple,
};

final fontSelectionProvider = StateProvider<String>((ref) => 'Kumbh Sans');

final tempFontSelectionProvider = StateProvider<String>((ref) => 'Kumbh Sans');
