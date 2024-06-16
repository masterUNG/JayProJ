// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.hint,
    this.label,
    this.obsecu,
    this.suffixWidget,
    this.validateFunc,
    this.textEditingController,
    this.autofocus,
    this.onSaved,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  final String? hint;
  final String? label;
  final bool? obsecu;
  final Widget? suffixWidget;
  final String? Function(String?)? validateFunc;
  final TextEditingController? textEditingController;
  final bool? autofocus;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: TextFormField(focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onSaved,
        autofocus: autofocus ?? false,
        controller: textEditingController,
        validator: validateFunc,
        obscureText: obsecu ?? false,
        decoration: InputDecoration(
          labelText: label,
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
