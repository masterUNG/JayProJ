// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.gfButtonType,
    this.color,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final GFButtonType? gfButtonType;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: pressFunc,
      text: label,
      type: gfButtonType ?? GFButtonType.solid,color: color ?? Theme.of(context).primaryColor,
    );
  }
}
