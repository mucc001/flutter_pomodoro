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

    return GestureDetector(
      onTap: () {
        ref.read(tempFontSelectionProvider.notifier).state = fontFamily;
      },
      child: Container(
        width: 40,
        height: 40,
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
              fontSize: 15,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
