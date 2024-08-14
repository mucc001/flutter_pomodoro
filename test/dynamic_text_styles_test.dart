import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DynamicTextStyles', () {
    late DynamicTextStyles dynamicTextStyles;

    setUp(() {
      dynamicTextStyles = DynamicTextStyles('Kumbh Sans', AppColors.textWhite);
    });

    test('getH1 returns correct TextStyle', () {
      final textStyle = dynamicTextStyles.getH1();
      expect(textStyle.fontSize, 100);
      expect(textStyle.fontWeight, FontWeight.bold);
      expect(textStyle.color, AppColors.textWhite);
      expect(textStyle.height, 120 / 100);
      expect(textStyle.letterSpacing, -5);
      expect(textStyle.fontFamily, 'KumbhSans_700');
    });

    test('getH2 returns correct TextStyle', () {
      final textStyle = dynamicTextStyles.getH2();
      expect(textStyle.fontSize, 28);
      expect(textStyle.fontWeight, FontWeight.bold);
      expect(textStyle.color, AppColors.textWhite);
      expect(textStyle.height, 34 / 28);
      expect(textStyle.fontFamily, 'KumbhSans_700');
    });

    test('getH3 returns correct TextStyle', () {
      final textStyle = dynamicTextStyles.getH3();
      expect(textStyle.fontSize, 16);
      expect(textStyle.fontWeight, FontWeight.bold);
      expect(textStyle.color, AppColors.textWhite);
      expect(textStyle.height, 19 / 16);
      expect(textStyle.letterSpacing, 15);
      expect(textStyle.fontFamily, 'KumbhSans_700');
    });

    test('getH4 returns correct TextStyle', () {
      final textStyle = dynamicTextStyles.getH4();
      expect(textStyle.fontSize, 13);
      expect(textStyle.fontWeight, FontWeight.bold);
      expect(textStyle.color, AppColors.textWhite);
      expect(textStyle.height, 16 / 13);
      expect(textStyle.letterSpacing, 5);
      expect(textStyle.fontFamily, 'KumbhSans_700');
    });

    test('getBody1 returns correct TextStyle', () {
      final textStyle = dynamicTextStyles.getBody1();
      expect(textStyle.fontSize, 14);
      expect(textStyle.fontWeight, FontWeight.bold);
      expect(textStyle.color, AppColors.textWhite);
      expect(
          textStyle.height, 18 / 14); // 18 line height divided by 14 font size
      expect(textStyle.fontFamily, 'KumbhSans_700');
    });

    test('getBody2 returns correct TextStyle', () {
      final textStyle = dynamicTextStyles.getBody2();
      expect(textStyle.fontSize, 12);
      expect(textStyle.fontWeight, FontWeight.bold);
      expect(textStyle.color, AppColors.textWhite);
      expect(
          textStyle.height, 14 / 12); // 14 line height divided by 12 font size
      expect(textStyle.fontFamily, 'KumbhSans_700');
    });

    test('getTextStyle handles invalid fontFamily', () {
      // Test with an invalid font family
      try {
        dynamicTextStyles.getH1(fontFamily: 'Invalid Font');
        fail('Expected ArgumentError for invalid font family');
      } catch (e) {
        expect(e, isA<ArgumentError>());
        expect((e as ArgumentError).message, contains('Invalid font family'));
      }
    });

    test('getTextStyle handles custom color', () {
      const customColor = Colors.red;
      final textStyle = dynamicTextStyles.getH1(color: customColor);
      expect(textStyle.color, customColor);
    });
  });
}
