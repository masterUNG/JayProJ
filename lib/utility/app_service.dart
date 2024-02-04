import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jayproj/models/data_model.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/utility/app_controller.dart';
import 'package:jayproj/utility/app_dialog.dart';
import 'package:jayproj/widgets/widget_button.dart';
import 'package:jayproj/widgets/widget_text.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processUploadAndEditData() async {
    String nameFile = '${appController.resultQR.value.trim()}.jpg';

    Map<String, dynamic> map = {};
    map['file'] = await dio.MultipartFile.fromFile(
        appController.files.last.path,
        filename: nameFile);
    dio.FormData formData = dio.FormData.fromMap(map);
    await dio.Dio()
        .post(AppConstant.urlSaveFile, data: formData)
        .then((value) async {
      String urlImage = '${AppConstant.domain}image/$nameFile';
      print('urlImage ----> $urlImage');

      String nonComplete = appController.chooseNonConpleateTitles.last ?? '';

      String urlAPI =
          'https://www.androidthai.in.th/fluttertraining/JayProJ/editImageWhereNumber.php?isAdd=true&number=${appController.resultQR.value.trim()}&img_bill=$urlImage&inv_status=${appController.chooseStatus.last}&nonComplete=$nonComplete&latt1=${appController.positions.last.latitude}&long1=${appController.positions.last.longitude}';

      await dio.Dio().get(urlAPI).then((value) {
        appController.resultQR.value = '';

        appController.dataModels.clear();

        appController.files.clear();

        appController.chooseStatus.clear();
        appController.chooseStatus.add(null);

        appController.chooseNonConpleateTitles.clear();
        appController.chooseNonConpleateTitles.add(null);

        Get.snackbar('Save Success', 'ThankYou Save Data');
      });
    });
  }

  Future<void> processTakePhoto() async {
    var result = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);

    if (result != null) {
      File file = File(result.path);
      appController.files.add(file);
    }
  }

  Future<void> processCheckQRcode({required String number}) async {
    String urlApi = '${AppConstant.urlGetDataWhereNumber}$number';

    await dio.Dio().get(urlApi).then((value) {
      if (appController.dataModels.isNotEmpty) {
        appController.dataModels.clear();
      }

      if (value.toString() == 'null') {
        Get.snackbar('No Data', 'No Data for code = $number');
      } else {
        json.decode(value.data).forEach((element) {
          DataModel dataModel = DataModel.fromMap(element);
          appController.dataModels.add(dataModel);
        });
      }
    });
  }

  Future<void> processFindLocation() async {
    bool locationService = await Geolocator.isLocationServiceEnabled();

    if (locationService) {
      //Open Service

      LocationPermission locationPermission =
          await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        // Denied Forver ไม่อนุญาติเลย
        dialogCallPermission();
      } else {
        //Away, One, Denied

        if (locationPermission == LocationPermission.denied) {
          //Deied

          locationPermission = await Geolocator.requestPermission();

          if ((locationPermission != LocationPermission.always) &&
              (locationPermission != LocationPermission.whileInUse)) {
            //DeniedForever
            dialogCallPermission();
          } else {
            //Away, One
            Position position = await Geolocator.getCurrentPosition();
            appController.positions.add(position);
          }
        } else {
          //Away, One
          Position position = await Geolocator.getCurrentPosition();
          appController.positions.add(position);
        }
      }
    } else {
      //Off Service
      AppDialog().normalDialog(
          title: 'Off Location Service',
          contentWidget: const WidgetText(data: 'Please Open Location Service'),
          secondWidget: WidgetButton(
            label: 'Open Service',
            pressFunc: () async {
              await Geolocator.openLocationSettings();
              exit(0);
            },
          ));
    }
  }

  void dialogCallPermission() {
    AppDialog().normalDialog(
        title: 'เปิด แชร์พิกัด',
        contentWidget: const WidgetText(data: 'กรุณาเปิดการแชร์ พิกัด ด้วยคะ'),
        secondWidget: WidgetButton(
          label: 'Open Permission',
          pressFunc: () async {
            await Geolocator.openAppSettings();
            exit(0);
          },
        ));
  }
}
