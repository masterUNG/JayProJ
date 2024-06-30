// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart' as dio;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jayproj/models/amount_mitsu_model.dart';
import 'package:jayproj/models/data_model.dart';
import 'package:jayproj/models/mitsu_model.dart';
import 'package:jayproj/models/user_model.dart';
import 'package:jayproj/states/main_home.dart';
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
          'https://www.androidthai.in.th/fluttertraining/JayProJ/editImageWhereNumber.php?isAdd=true&number=${appController.resultQR.value.trim()}&img_bill=$urlImage&inv_status=${appController.chooseStatus.last}&nonComplete=$nonComplete&latt1=${appController.positions.last.latitude}&long1=${appController.positions.last.longitude}&WEBSCAN=${appController.resultQR.value.trim()}&WEBSCANDATE=${DateTime.now()}&WEBSCANBY=${appController.currentUserModels.last.mem_name}';

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

  Future<void> processCheckLogin({
    required String user,
    required String password,
  }) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/JayProJ/getUserWhereMemUser.php?isAdd=true&mem_username=$user';

    await dio.Dio().get(urlApi).then((value) async {
      if (value.toString() == 'null') {
        Get.snackbar('User False', 'No $user in my Database',
            backgroundColor: GFColors.DANGER, colorText: GFColors.WHITE);
      } else {
        for (var element in json.decode(value.data)) {
          UserModel userModel = UserModel.fromMap(element);

          String passwordSha1 = userModel.mem_password;
          print('## passowordSha1---> $passwordSha1');

          var bytes = utf8.encode(password);
          var userPasswordSha1 = sha1.convert(bytes);
          print('## yserPasswordSha1 --> $userPasswordSha1');

          if (passwordSha1 == userPasswordSha1.toString()) {
            //Password True

            await GetStorage().write('data', userModel.toMap()).then((value) {
              Get.snackbar('Authen Success',
                  'Welcome คุณ${userModel.mem_name} To my App');

              // Get.offAll(const MainScan());
              Get.offAll(const MainHome());
            });
          } else {
            Get.snackbar('Password False', 'Please Try Again',
                backgroundColor: GFColors.WARNING);
          }
        }
      }
    });
  }

  Future<void> processFindUserLogin() async {
    var data = await GetStorage().read('data');
    UserModel userModel = UserModel.fromMap(data);
    appController.currentUserModels.add(userModel);
  }

  Future<MitsuModel?> readMitsuData({required String code}) async {
    MitsuModel? mitsuModel;

    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/JayProJ/getMitsuWhereCode.php?isAdd=true&code=$code';

    var result = await dio.Dio().get(urlApi);

    if (result.toString() != 'null') {
      for (var element in json.decode(result.data)) {
        mitsuModel = MitsuModel.fromMap(element);
      }
    }
    return mitsuModel;
  }

  Future<AmountMitsuModel?> readAmountMitsuData({required String code}) async {
    AmountMitsuModel? amountMitsuModel;

    var mapUserModel = await GetStorage().read('data');

    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/JayProJ/getAmountMitsuWhereCode.php?isAdd=true&code=$code&userId=${mapUserModel["mem_name"]}';

    var result = await dio.Dio().get(urlApi);

    print('##30june urlAPI ===> $urlApi');
    print('##30june result ===> $result');

    if (result.toString() == 'null') {

      Get.snackbar('New Code', 'Create New Code to Temp');

      // Without Data --> code จะสร้างข้อมูลใหม่ ตามโค้ดที่ สแกนได้
      var model = await readMitsuData(code: code);
      amountMitsuModel = AmountMitsuModel(
        id: '0',
        code: code,
        name: model?.name ?? '',
        qty: '1',
        userId: mapUserModel['mem_name'],
        lat: appController.positions.last.latitude.toString(),
        lng: appController.positions.last.longitude.toString(),
        status: '0',
        timestamp: '',
      );

      String urlApiInsert =
          'https://www.androidthai.in.th/fluttertraining/JayProJ/insertAmountMitsu.php?isAdd=true&code=$code&name=${model?.name ?? ""}&qty=1&userId=${mapUserModel["mem_name"]}&lat=${appController.positions.last.latitude}&lng=${appController.positions.last.longitude}';

      await dio.Dio().get(urlApiInsert);

      // readAmountMitsuData(code: code);
    } else {
      // Have Data --> code

      for (var element in json.decode(result.data)) {
        AmountMitsuModel model = AmountMitsuModel.fromMap(element);

        Map<String, dynamic> map = model.toMap();

        int qty = int.parse(map['qty']);
        qty = qty + 1;

        map['qty'] = qty.toString();

        String urlApiEditQty =
            'https://www.androidthai.in.th/fluttertraining/JayProJ/editQtyWhereId.php?isAdd=true&id=${model.id}&qty=${map["qty"]}';
        await dio.Dio().get(urlApiEditQty);

        amountMitsuModel = AmountMitsuModel.fromMap(map);
      }
    }
    return amountMitsuModel;
  }

  Future<List<AmountMitsuModel>> readAmountMitsuDataWhereLogin() async {
    var amountMitsuModels = <AmountMitsuModel>[];
    var mapUserModel = await GetStorage().read('data');

    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/JayProJ/getAmountMitsuWhereLogin.php?isAdd=true&userId=${mapUserModel["mem_name"]}';

    print('##24may urlAPI ---> $urlApi');

    var result = await dio.Dio().get(urlApi);

    print('##24may result ======> $result');

    if (result.toString() != 'null') {
      for (var element in json.decode(result.data)) {
        AmountMitsuModel amountMitsuModel = AmountMitsuModel.fromMap(element);
        amountMitsuModels.add(amountMitsuModel);
      }
    }
    return amountMitsuModels;
  }

  Future<void> processUpdateStatus(
      {required String id, required String newStatus}) async {
    String urlAPI =
        'https://www.androidthai.in.th/fluttertraining/JayProJ/editStatusWhereId.php?isAdd=true&id=$id&status=$newStatus';

    await dio.Dio().get(urlAPI);
  }

  Future<void> processSave(
      {required List<AmountMitsuModel> amountMitsuModels}) async {
    for (var element in amountMitsuModels) {
      String urlAPI =
          'https://www.androidthai.in.th/fluttertraining/JayProJ/insertAmountMitsuAll.php?isAdd=true&code=${element.code}&name=${element.name}&qty=${element.qty}&userId=${element.userId}&lat=${element.lat}&lng=${element.lng}&status=${element.status}&timestamp=${element.timestamp}';

      await dio.Dio().get(urlAPI);
    }
  }

  Future<void> processCancel(
      {required List<AmountMitsuModel> amountMitsuModels}) async {
    for (var element in amountMitsuModels) {
      String urlAPI =
          'https://www.androidthai.in.th/fluttertraining/JayProJ/deleteWhereId.php?isAdd=true&id=${element.id}';

      await dio.Dio().get(urlAPI);
    }
  }
}
