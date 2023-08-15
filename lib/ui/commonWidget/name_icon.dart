import 'package:broking/theme/my_theme.dart';
import 'package:flutter/material.dart';

class NameIcon extends StatelessWidget {
  final String firstName;
  final Color backgroundColor;
  final Color textColor;
   NameIcon({super.key,  required this.firstName, this.backgroundColor= MyColors.backgroundBg, this.textColor= Colors.white,});


  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Text(firstName.substring(0, 1).toUpperCase(), style: TextStyle(color: textColor)),
      ),
    );
  }
}