import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan/scan.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  ScanController scanController = ScanController();

  @override
  void dispose() {
    scanController.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScanView(
        controller: scanController,
        onCapture: (data) {
          Get.back(result: data);
        },
      ),
    );
  }
}
