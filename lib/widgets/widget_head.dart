// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/widgets/widget_text.dart';

class WidgetHead extends StatelessWidget {
  const WidgetHead({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(color: color),
      child: const Row(
        children: [
          Expanded(
            flex: 1,
            child: WidgetText(data: 'QTY', textStyle: TextStyle(color: GFColors.WHITE),),
          ),
          Expanded(
            flex: 2,
            child: WidgetText(data: 'Code', textStyle: TextStyle(color: GFColors.WHITE),),
          ),
          Expanded(
            flex: 2,
            child: WidgetText(data: 'Name', textStyle: TextStyle(color: GFColors.WHITE),),
          ),
          Expanded(
            flex: 1,
            child: WidgetText(data: 'No:', textStyle: TextStyle(color: GFColors.WHITE),),
          ),
        ],
      ),
    );
  }
}
