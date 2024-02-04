import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jayproj/models/data_model.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/utility/app_controller.dart';

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
          'https://www.androidthai.in.th/fluttertraining/JayProJ/editImageWhereNumber.php?isAdd=true&number=${appController.resultQR.value.trim()}&img_bill=$urlImage&inv_status=${appController.chooseStatus.last}&nonComplete=$nonComplete';

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
}
