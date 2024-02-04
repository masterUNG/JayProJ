import 'package:flutter/material.dart';
import 'package:jayproj/widgets/widget_form.dart';
import 'package:jayproj/widgets/widget_logo.dart';

class Authen extends StatelessWidget {
  const Authen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            margin: const EdgeInsets.only(top: 64),
            child: const Column(
              children: [
                WidgetLogo(),
                WidgetForm(hint: 'User :',),
                WidgetForm(hint: 'Password :',),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

