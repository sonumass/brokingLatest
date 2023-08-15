import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class Loader extends StatelessWidget {
  final bool addOpacity;

  const Loader({
    Key? key,
    this.addOpacity = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              if (addOpacity)
                const Opacity(
                  opacity: 0.65,
                  child: ModalBarrier(dismissible: false, color: Palette.appColor),
                ),
              appLoader
            ],
          ),
        ));
  }

  Widget get appLoader {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 30, right: 30),
        decoration: const BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.30, 0.70],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Palette.backgroundBgTopLeft,
              Palette.backgroundBgBottomLeft,
            ],
          ),
        ),
        child: const CircularProgressIndicator(color: Palette.kColorWhite,));
  }
}
