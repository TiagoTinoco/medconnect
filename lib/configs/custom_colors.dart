import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(4, 47, 77, .1),
  100: const Color.fromRGBO(4, 47, 77, .2),
  200: const Color.fromRGBO(4, 47, 77, .3),
  300: const Color.fromRGBO(4, 47, 77, .4),
  400: const Color.fromRGBO(4, 47, 77, .5),
  500: const Color.fromRGBO(4, 47, 77, .6),
  600: const Color.fromRGBO(4, 47, 77, .7),
  700: const Color.fromRGBO(4, 47, 77, .8),
  800: const Color.fromRGBO(4, 47, 77, .9),
  900: const Color.fromRGBO(4, 47, 77, 1),
};

abstract class CustomColors {
  static MaterialColor primary = MaterialColor(0xFF042F4D, _swatchOpacity);
  static Color warning = const Color(0xFFC94949);
  static Color secondary = const Color(0xFFFFB600);
}
