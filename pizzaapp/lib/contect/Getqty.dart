// ignore_for_file: camel_case_types, file_names

import 'package:get/get.dart';

class qtycontrol extends GetxController {
  var counter = 1.obs;
  // ignore: unused_field

  void qtyincreament() {
    counter.value++;
  }

  void qtydecreament() {
    if (counter.value-- == 1) {
      counter.value = 1;
    }
  }
}
