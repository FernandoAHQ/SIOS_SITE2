import 'package:flutter/material.dart';

class Apptheme {

  static const Color primarylight = Color(0xFF154DFC);
  static const Color primarydark  = Color(0xFF3636ff);
  static const Color secondary    = Color(0xFF807E82);
  static const Color black        = Color(0xFF303030);
  static const Color white        = Colors.white;

  static final ThemeData lightTheme = ThemeData.light().copyWith(

    primaryColor: primarylight,

  );
}