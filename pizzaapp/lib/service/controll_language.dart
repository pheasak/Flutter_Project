import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class controller_language extends GetxController {
  // ignore: non_constant_identifier_names
  RxInt index_seleted = 0.obs;
  final local = [
    {
      'locale':const Locale('en', 'EN'),
    },
    {
      'locale':const Locale('kh', 'KH'),
    },
    {
      'locale':const Locale('ch', 'CH'),
    }
  ];
  void uploadLocal(Locale locale) {
    Get.updateLocale(locale);
  }
}
