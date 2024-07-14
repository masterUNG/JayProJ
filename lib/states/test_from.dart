import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jayproj/widgets/widget_button.dart';

class TestForm extends StatefulWidget {
  const TestForm({super.key});

  @override
  State<TestForm> createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  FocusNode? focusNode;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    focusNode = FocusNode();

    delayKeyboard();

    super.initState();
  }

  Future<void> delayKeyboard() async {
    Future.delayed(const Duration(microseconds: 500), () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.symmetric(horizontal: 36),
            child: TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              onChanged: (value) {
                processShowValue(value: value);
              },
              onFieldSubmitted: (value) {
                focusNode!.requestFocus();

                delayKeyboard().then((value) {});
              },
              autofocus: true,
            ),
          ),
          // WidgetButton(
          //   label: 'Focus',
          //   pressFunc: () {
          //     focusNode!.requestFocus();
          //   },
          // )
        ],
      )),
    );
  }

  void processShowValue({required String value}) {
    Get.snackbar(value, value);
    textEditingController.clear();
    focusNode!.requestFocus();
  }
}
