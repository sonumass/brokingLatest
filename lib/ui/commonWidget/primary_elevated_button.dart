import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import '../commonwidget/text_style.dart';

class PrimaryElevatedBtn extends StatefulWidget {
  final String _text;
  final Widget? icon;
  final VoidCallback? _onClicked;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final double borderRadius;
  final Color color;
  final Color textColor;

  const PrimaryElevatedBtn(this._text, this._onClicked,
      {this.icon,
      this.buttonStyle,
      this.textStyle,
      this.borderRadius = 8.0,
        this.color=Palette.kColorWhite,
        this.textColor=Palette.appColor,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PrimaryElevatedBtnState();
  }
}

class _PrimaryElevatedBtnState extends State<PrimaryElevatedBtn> {
  @override
  void didUpdateWidget(covariant PrimaryElevatedBtn oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget._onClicked,
      child: _text,
      style: buttonStyle(widget.color),
    );
  }

  Widget get _text {
    return Text(
      widget._text,
      style: widget.textStyle ??
          TextStyles.headingTexStyle(
            letterSpacing:1,
            color: widget.textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  ButtonStyle  buttonStyle(Color color) {
    return widget.buttonStyle ??
        ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius))),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> state) {
              if (state.contains(MaterialState.pressed)) {
                return color;
              } else if (state.contains(MaterialState.disabled)) {
                return color;
              }
              return color;
            }));
  }
}
