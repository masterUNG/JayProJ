import 'package:flutter/material.dart';
import 'package:jayproj/widgets/widget_text.dart';

class SecondScan extends StatelessWidget {
  const SecondScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WidgetText(data: 'This Sccond Scan'),);
  }
}