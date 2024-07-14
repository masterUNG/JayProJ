// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    Key? key,
    required this.iconData,
    required this.pressFunc,
    this.color,
  }) : super(key: key);

  final IconData iconData;
  final Function() pressFunc;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GFIconButton(color: color ?? Theme.of(context).primaryColor,
      icon: Icon(iconData),
      onPressed: pressFunc,
      type: GFButtonType.transparent,
    );
  }
}
