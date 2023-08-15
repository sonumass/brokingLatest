import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
class Singleton{
  static final Singleton singleton=Singleton._internal();
  factory Singleton(){
    return singleton;
  }
  Singleton._internal(){
    //internal logic;

  }
}