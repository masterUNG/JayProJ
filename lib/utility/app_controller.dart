import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jayproj/models/data_model.dart';

class AppController extends GetxController {
  RxString resultQR = ''.obs;

  RxList<DataModel> dataModels = <DataModel>[].obs;

  RxList<File> files = <File>[].obs;

  RxList<int?> chooseStatus = <int?>[null].obs;

  RxList<String?> chooseNonConpleateTitles = <String?>[null].obs;

  RxList<Position> positions = <Position>[].obs;

  RxBool redEye = true.obs;
}
