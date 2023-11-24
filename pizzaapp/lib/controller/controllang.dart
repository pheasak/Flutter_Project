import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/Global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class controllerLanguage extends GetxController {
  RxInt selectIndex = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getLanguage();
    super.onInit();
  }

  Future changeLanguage(Locale langaugcode) async {
    Get.updateLocale(langaugcode);
  }

  void getLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    selectIndex.value = preferences.getInt('Index') ?? 0;
    update();
    // ignore: avoid_print
    print('get index :${preferences.getInt('Index')}');
    Get.updateLocale(local[selectIndex.value]['locale']!);
  }
}
