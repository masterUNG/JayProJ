import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AppConstant {
  static var appBarColors = <Color>[
    Colors.blue.shade700,
    Colors.pink.shade700,
  ];

  static Color appColor = const Color.fromARGB(255, 143, 164, 8);

  static var nameDevice = <String>[
    'Mobile',
    'Reader',
  ];

  static var titleSlids = <String>[
    'Off',
    'On',
  ];

  static var colors = <Color>[GFColors.DANGER, Colors.green.shade700];
  static var colorTexts = <Color>[Colors.black, Colors.white];
  static var colorBGs = <Color>[GFColors.WHITE, GFColors.DANGER];

  static var nonCompleateTitles = <String>[
    'ของชำรุด',
    'ไม่ตรงตามสั่ง',
    'ยกเลิก',
    'อื่นๆ',
  ];

  static String domain =
      'https://www.androidthai.in.th/fluttertraining/JayProJ/';

  static String urlSaveFile =
      'https://www.androidthai.in.th/fluttertraining/JayProJ/saveFile.php';

  static String urlGetDataWhereNumber =
      'https://www.androidthai.in.th/fluttertraining/JayProJ/getDataWhereNumber.php?isAdd=true&number=';

  BoxDecoration linearBox({
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
  }) =>
      BoxDecoration(
          gradient: LinearGradient(
        colors: <Color>[Colors.white, appColor],
        begin: begin ?? Alignment.centerLeft,
        end: end ?? Alignment.centerRight,
      ));

  BoxDecoration radialBox() => BoxDecoration(
          gradient: RadialGradient(
        colors: <Color>[Colors.white, appColor],
        radius: 1.0,
      ));

  TextStyle h1Style({
    double? size,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
        fontSize: size ?? 36,
        color: color,
        fontWeight: fontWeight ?? FontWeight.bold);
  }

  TextStyle h2Style({
    double? size,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
        fontSize: size ?? 22,
        color: color,
        fontWeight: fontWeight ?? FontWeight.w700);
  }

  TextStyle h3Style({
    double? size,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
        fontSize: size ?? 14,
        color: color,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  BoxDecoration radiusBorder() => BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      );
}
