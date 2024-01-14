import 'package:flutter/material.dart';
import 'package:jayproj/widgets/widget_text.dart';

class WidgetHeadTail extends StatelessWidget {
  const WidgetHeadTail({
    Key? key,
    required this.head,
    required this.tail,
  }) : super(key: key);

  final String head;
  final String tail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         WidgetText(data: head),
        WidgetText(data: tail),
      ],
    );
  }
}