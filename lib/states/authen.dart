import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayproj/utility/app_controller.dart';
import 'package:jayproj/widgets/widget_button.dart';
import 'package:jayproj/widgets/widget_form.dart';
import 'package:jayproj/widgets/widget_icon_button.dart';
import 'package:jayproj/widgets/widget_logo.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(top: 64),
                  child: Column(
                    children: [
                      WidgetLogo(),
                      WidgetForm(
                        hint: 'User :',
                        suffixWidget: Icon(Icons.person),
                      ),
                      Obx(() {
                        return WidgetForm(
                          hint: 'Password :',
                          obsecu: appController.redEye.value,
                          suffixWidget: WidgetIconButton(
                            iconData: appController.redEye.value
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                            pressFunc: () {
                              appController.redEye.value =
                                  !appController.redEye.value;
                            },
                          ),
                        );
                      }),
                      Container(width: 250,margin: const EdgeInsets.only(top: 8),
                        child: WidgetButton(
                          label: 'Login',
                          pressFunc: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
