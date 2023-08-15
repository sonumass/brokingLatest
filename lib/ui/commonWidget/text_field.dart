import 'package:flutter/material.dart';

class CustomWidgets {
  static Widget textField(String title,
      {bool isPassword = false,
        bool isNumber = false,
        required TextEditingController textController,
        int lines = 1}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          SizedBox(width: 20,child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),),


        ],
      ),
    );
  }
}