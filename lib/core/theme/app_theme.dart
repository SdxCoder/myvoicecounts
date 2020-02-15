import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final overlayColor = const Color(0xff000000).withAlpha(150);

// #ff9705

ThemeData themeData = ThemeData(
  primaryColor: Color(hexColor('#a62d91')),
  primaryColorDark: Color(hexColor('#211535')),
  primaryColorLight: Color(hexColor('#b72b9b')),
  accentColor: Color(hexColor('#ff9300')),
  textTheme: TextTheme(
    display1: TextStyle(color : Color(hexColor('f2f2f2')), fontSize: 18),
    display2: TextStyle(color : Color(hexColor('f2f2f2')), fontSize: 22),
    display3: TextStyle(color : Color(hexColor('f2f2f2')), fontSize: 26),
    display4: TextStyle(color : Color(hexColor('f2f2f2')), fontSize: 36),
    body1:  TextStyle(color: Color(hexColor('f2f2f2')), fontSize: 16),
  )
);

LinearGradient gradient3 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      themeData.primaryColorLight,
      themeData.primaryColor,
      themeData.primaryColorDark,
    ]);


LinearGradient gradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      themeData.primaryColorLight,
      themeData.primaryColor,
    ]);

hexColor(String hexCode) {
  String colorst = '0xff' + hexCode.replaceAll('#', '');
  int color = int.parse(colorst);
  return color;
}
