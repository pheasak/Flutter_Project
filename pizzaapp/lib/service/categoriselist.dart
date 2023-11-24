import 'package:get/get.dart';

class Listcard {
  final String name, icon;
  Listcard({required this.icon, required this.name});
  static List<Listcard> lscard = [
    Listcard(icon: 'asset/svg/Pizza.svg', name: 'Pizza'.tr),
    Listcard(icon: 'asset/svg/appetizer.svg', name: 'Appetizer'.tr),
    Listcard(icon: 'asset/svg/salad.svg', name: 'Salad'.tr),
    Listcard(icon: 'asset/svg/vigetable.svg', name: 'Vigetable'.tr),
    Listcard(icon: 'asset/svg/chicken.svg', name: 'Fries Chicken'.tr),
    Listcard(icon: 'asset/svg/cake.svg', name: 'cake'.tr),
    Listcard(icon: 'asset/svg/ice.svg', name: 'Ice-Cream'.tr),
    Listcard(icon: 'asset/svg/rice.svg', name: 'Ice dishes'.tr),
    Listcard(icon: 'asset/svg/pasta.svg', name: 'Pasta'.tr),
    Listcard(icon: 'asset/svg/promote2.svg', name: 'Promotion'.tr)
  ];
}
