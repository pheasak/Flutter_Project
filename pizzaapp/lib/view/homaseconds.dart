import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/view/Pickup.dart';
import 'package:pizzaapp/view/Textfield.dart';
import 'package:pizzaapp/view/bundles.dart';
import 'package:pizzaapp/view/category.dart';
import 'package:pizzaapp/view/slideimage.dart';

class HomePageSeconds extends StatelessWidget {
  const HomePageSeconds({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => PickUpLocal());
              },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(0, 1))
                    ]),
                //bottombar
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Pickup Location',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          const Text(
                            'Pizza Smaki (CHPSK)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.5),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              '0',
                              style: TextStyle(fontSize: 20),
                            ),
                            const Icon(Icons.shopping_cart_outlined)
                          ],
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ),
            //Imagslide
            SlideIamge(),
            // TextField
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        const BoxShadow(
                            blurRadius: 3,
                            offset: Offset(1, 1),
                            color: Colors.grey)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const mytext()),
            ),
            // Bundles
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Bundles'.tr,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: RowProduct(),
            ),
            //Categories
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Categories'.tr,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Categories()
          ],
        ),
      ),
    );
  }
}
