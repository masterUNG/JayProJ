import 'package:flutter/material.dart';

class AppConstant {
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
