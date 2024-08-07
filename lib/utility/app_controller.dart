import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:jayproj/models/data_model.dart';
import 'package:jayproj/models/user_model.dart';

class AppController extends GetxController {
  RxString resultQR = ''.obs;

  RxList<DataModel> dataModels = <DataModel>[].obs;

  RxList<File> files = <File>[].obs;

  RxList<int?> chooseStatus = <int?>[null].obs;

  RxList<String?> chooseNonConpleateTitles = <String?>[null].obs;

  RxList<Position> positions = <Position>[].obs;

  RxBool redEye = true.obs;

  RxBool displayForm = false.obs;

  RxList<UserModel> currentUserModels = <UserModel>[].obs;

  RxInt indexBody = 0.obs;

  RxList<int?> indexDevices = <int?>[null, 0].obs;

  RxList contentWidgets = <Widget>[].obs;

  RxList textInputType = <TextInputType>[TextInputType.none].obs;
}
