import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Palette {
  Palette._();

  static const MaterialColor appColor = MaterialColor(0xFF8F2960, {
    50: Color(0x868F2960),
    100: Color(0x118F2960),
    200: Color(0x228F2960),
    300: Color(0x338F2960),
    400: Color(0x448F2960),
    500: Color(0x558F2960),
    600: Color(0x668F2960),
    700: Color(0x778F2960),
    800: Color(0x888F2960),
    900: Color(0x998F2960),
  });

  static const Color prospectCardTextColor = Color(0xff392A64);
  static const Color cardHeader = Color(0xff824182);
  static const Color searchView = Color(0xff5B436F);
  static const Color lightColor = Color(0xffBCADC4);
  static const Color iconbgColor = Color(0xff341652);
  static const Color textBgColor = Color(0xff8B6AE5);

  static const Color appBar = Color(0xff7A3062);
  static const Color backgroundBgFirst = Color(0xff8F2960);
  static const Color backgroundBgBottomLeft = Color(0xff393C77);
  static const Color backgroundBgTopLeft = Color(0xff8D2961);
  static const Color backgroundBgSec = Color(0xff2C3F7A);
  static const Color backgroundBg = Color(0xffc2ade0);
  static const Color colorPrimary = Color(0xffB8DAE6);
  static const Color colorPrimaryDark = Color(0xffB8DAE6);
  static const Color colorTextGrey = Color(0xff7C7C7C);
  static const Color colorTextBlack = Color(0xff000000);
  static const Color colorPageBg = Colors.white;
  static const Color colorWhite = Colors.white;
  static const Color coloPageBg = Colors.white;
  static const Color labelColor = Colors.black;
  static const Color labelHintColor = Colors.grey;
  static const Color textColor = Color(0xFF282828);
  static const Color cardBg = Color(0xff9577d5);
  static const Color textOnThemeBg = Color(0xffFAFAFA);


  static Color transparent = Color(0x00FFFFFF);
  static const Color backgroundWhiteColor = Color(0xffFAFAFA);
  static Color backgroundColor = Color(0xF7216274);
  static Color backgroundColor2 = Color(0xF73195AF);
  static Color buttonsColor = Color(0xF7CC7F00);
  static Color drawerColor = Color(0xF7895501);
  static const Color buttonBorderColor = Color(0xF7FFC971);
  static Color buttonsColor2 = Color(0xF721ACBF);
  static Color buttonlightColor = Color(0xF768A8B9);
  static Color fillColor = Color(0xFFF6F6FE);

  static Color fillDarkColor = Color(0xFFF5F1FD);
  static Color kColorGreen = Colors.green;
  static Color kColorGreenDark = Color(0xFF008E06);
  static Color kColorBlue = Colors.blue;

  static const Color secondaryAppColor = Color(0xFF216274);
  static const Color skyColor = Color(0xFF00CFFF);
  static const Color disableColor = Color.fromRGBO(237, 237, 237, 1.0);
  static const Color kColorBGGrey = Color(0xFFF9F9F9);
  static const Color kColorWhite = Color(0xFFFFFFFF);
  static const Color kColorLightWhite = Color(0xFFF2F2F1);
  static const Color ColorBackgraundWhite = Color(0xFFF8FCFD);
  static const Color kColorGold = Color(0xFFA97625);
  static Color kColorExtraLightGrey = Color(0xFFC4C4DB);

  //static const kPrimaryColor = Color(0xFF6F35A5);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);

  // static const Color kColorExtraLightGrey = Color(0x14002126);
  static const Color kTextColorBlack = Color(0x99002126);
  static const Color kTextColorBlue = Color(0xFF141F47);
  static const Color kColorSemiBlack = Color(0x88000000);
  static const Color kColorLightBlack = Color(0x76000000);
  static const Color kColorSemiLightBlack = Color(0x66000000);
  static const Color kColorExtraLightBlack = Color(0x30000000);
  static const Color kColorGrey = Colors.grey;

  static const Color kColorDarkGrey = Color(0xFF282828);
  static const Color kColorLightGrey = Color(0xF1282828);
  static const Color kColorLightGreyAlpha = Color(0x99AAAAAA);

  //static  Color kColorExtraLightGrey = Color(0xFFC4C4DB);

  static const Color kColorBorderGrey = Color(0xFFACA7A6);

  // static  Color kColorPurple = Color(0xFF85BD00);
  static const Color kColorLightGreen = Color(0xFFA0F9A0);
  static const Color kColorLightBGPurple = Color(0xFFF4F3FF);
  static const Color kColorLightBGGreen = Color(0xFFE7FCE8);
  static const Color kColorLightBGreen = Color(0xFFDEEED8);
  static const Color lightBlack = Color(0xFF272727);
  static const Color kColorOrange = Color(0xFFFFBE00);
  static const Color kColorBorder = Color(0x33000000);
  static const Color kColorRed = Color(0xFFFD0303);
  static const Color kColorLightRed = Color(0xFFFAD9D9);

  // static  Color kColorLightBGRed = Color(0xFAD9D9FF);
  static const Color lineColor = Color.fromRGBO(241, 241, 241, 1);

  static const Color kColorBlack = Colors.black;
  static const Color textHeadingColor = Color(0xFF392A64);
  static const Color kColorBlack50 = Color(0x05000000);
  static const Color kColorBlack100 = Color(0x10000000);
  static const Color kColorBlack200 = Color(0x22000000);
  static const Color kColorBlack300 = Color(0x38000000);
  static const Color kColorBlack400 = Color(0x40000000);
  static const Color kColorBlack500 = Color(0x55000000);
  static const Color kColorBlack600 = Color(0x66000000);
  static const Color kColorBlack700 = Color(0x70000000);
  static const Color kColorBlack800 = Color(0x88000000);
  static const Color kColorBlack900 = Color(0x99000000);
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
