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

  BoxDecoration radiusBorder() => BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      );
}
