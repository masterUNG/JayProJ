// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.hint,
    this.obsecu,
    this.suffixWidget,
    this.validateFunc,
    this.textEditingController,
  }) : super(key: key);

  final String? hint;
  final bool? obsecu;
  final Widget? suffixWidget;
  final String? Function(String?)? validateFunc;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: textEditingController,
        validator: validateFunc,
        obscureText: obsecu ?? false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade300,
          border: InputBorder.none,
          hintText: hint,
          suffixIcon: suffixWidget,
        ),
      ),
    );
  }
}
