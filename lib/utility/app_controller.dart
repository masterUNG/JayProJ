import 'dart:io';

import 'package:get/get.dart';
import 'package:jayproj/models/data_model.dart';

class AppController extends GetxController {
  
  RxString resultQR = ''.obs;

  RxList<DataModel> dataModels = <DataModel>[].obs;

  RxList<File> files = <File>[].obs;
}
