import 'package:flutter/material.dart';
import '../../utils/palette.dart';

class TextStyles {
  TextStyles._();

  static TextStyle headingTexStyle({
    Color color = Palette.colorTextBlack,
    FontWeight fontWeight = FontWeight.bold,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration decoration = TextDecoration.none,
    double fontSize = 0,
    String? fontFamily,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
        fontSize: fontSize == 0 ? 15 : fontSize,
        color: color,
        letterSpacing:letterSpacing==0.0?0.0:letterSpacing,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontFamily: fontFamily ?? "assets/font/Oswald-Regular.ttf",
        decoration: decoration,
        height: height == null ? null : height / 15);
  }

  static TextStyle labelTextStyle({
    double? letterSpacing,
    Color color = Palette.colorTextBlack,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration decoration = TextDecoration.none,
    double fontSize = 0,
    String? fontFamily,
    double? height,
  }) {
    return TextStyle(

        fontSize: fontSize == 0 ? 15 : fontSize,
        color: color,
        letterSpacing:letterSpacing==0.0?0.0:letterSpacing,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decoration,
        fontFamily: fontFamily ?? "assets/font/Oswald-Regular.ttf",
        height: height == null ? null : height / 15);
  }
}
