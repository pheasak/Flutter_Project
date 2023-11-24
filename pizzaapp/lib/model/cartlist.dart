import 'package:get/get.dart';

import '../service/backend/datacategories.dart';

// ignore: camel_case_types
class cartList extends GetxController {
  RxList cart = [].obs;
  RxDouble price = 0.0.obs;
  double total = 0.0;
  addTocart(TypeCategories categories) {
    // if (cart.isEmpty) {
    cart.add(categories.map() as TypeCategories);
    // } else {
    //   int index = cart.indexWhere((element) => element.id == categories.id);
    //   if (index < 0) {
    //     cart.add(categories);
    //   }
    // }
    update();
  }

  removeCart(TypeCategories pizzaList) {
    int index = cart.indexWhere((element) => element.map() == pizzaList.map());
    cart.removeAt(index);
    update();
  }

  // totalcontrol(int index) {
  //   total = (cart[index].price * cart[index].qty);
  // }

  // qtyIncrement(int index) {
  //   cart[index].qty = cart[index].qty++;
  //   update();
  // }

  // qtyDecreament(int index) {
  //   if (cart[index].qty > 1) {
  //     cart[index].qty--;
  //   }
  // }
}
