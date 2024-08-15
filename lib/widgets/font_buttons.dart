import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/providers/settings_provider.dart';

class FontButton extends ConsumerWidget {
  final String fontFamily;
  final Color backgroundColor;
  final Color textColor;

  const FontButton({
    super.key,
    required this.fontFamily,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFont = ref.watch(tempFontSelectionProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = screenWidth * 0.1; // Button size is 10% of screen width
    final fontSize = screenWidth * 0.04; // Font size is 4% of screen width

    return GestureDetector(
      onTap: () {
        ref.read(tempFontSelectionProvider.notifier).state = fontFamily;
      },
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: ShapeDecoration(
          color: selectedFont == fontFamily
              ? const Color(0xFF161932)
              : backgroundColor,
          shape: const OvalBorder(),
        ),
        child: Center(
          child: Text(
            'Aa',
            style: TextStyle(
              color: selectedFont == fontFamily ? Colors.white : textColor,
              fontSize: fontSize,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
