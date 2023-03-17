import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColor = HexColor.fromHex('#EB5E28');
  static Color yellowLiner = HexColor.fromHex('#C59E24');
  static Color amberLiner = HexColor.fromHex('#FFBF00');
  static Color grayLiner = HexColor.fromHex('#F2F2F2');
  static Color grayText = HexColor.fromHex('#161F3D');
  static Color blackText = HexColor.fromHex('#403D39');
  static Color black = Colors.black;
  static Color whiteLiner = HexColor.fromHex('#F6F6F6');
  static Color backgroundColor = HexColor.fromHex('#F6FCFE');
  static Color grayColor = HexColor.fromHex('#78736C');
  static Color gray2Color = HexColor.fromHex("#818181");
  static Color whiteColor = HexColor.fromHex('#FFFFFF'); //opacity50=>>>80
  static Color blueTxtColor = HexColor.fromHex('#174B80');
  static Color blueTxtColorO40 = HexColor.fromHex('#66174B80'); //opacity40=>>66
  static Color orangeTxtColor = HexColor.fromHex('#EB5E28');
  static Color blueAccentColor = HexColor.fromHex('#4FC7E4');
  static Color hintBlueAccentColor = HexColor.fromHex('#B4CCD1');
  static Color wight = HexColor.fromHex('#FFFFFF');
  static Color error = HexColor.fromHex('#e61f34');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString'; // 8 char with 100% opacity
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
