import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jayproj/utility/app_controller.dart';
import 'package:jayproj/utility/app_service.dart';
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

  final formKey = GlobalKey<FormState>();

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const WidgetLogo(),
                        WidgetForm(
                          textEditingController: userController,
                          validateFunc: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return 'Please Fill User';
                            } else {
                              return null;
                            }
                          },
                          hint: 'User :',
                          suffixWidget: const Icon(Icons.person),
                        ),
                        Obx(() {
                          return WidgetForm(
                            textEditingController: passwordController,
                            validateFunc: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return 'Please Fill Password';
                              } else {
                                return null;
                              }
                            },
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
                        Container(
                          width: 250,
                          margin: const EdgeInsets.only(top: 8),
                          child: WidgetButton(
                            label: 'Login',
                            pressFunc: () {
                              if (formKey.currentState!.validate()) {
                                AppService().processCheckLogin(
                                    user: userController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                        )
                      ],
                    ),
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
