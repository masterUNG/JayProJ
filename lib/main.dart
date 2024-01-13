import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayproj/states/main_scan.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: MainScan(),
    );
  }
}
