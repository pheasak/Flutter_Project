// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/controller/auth_controll.dart';
import 'package:pizzaapp/service/currentposittion.dart';
import 'package:pizzaapp/view/Addtocart.dart';
import 'package:pizzaapp/view/Textfield.dart';
import 'package:pizzaapp/view/bundles.dart';
import 'package:pizzaapp/view/category.dart';
import 'package:pizzaapp/view/googlemap.dart';
import 'package:pizzaapp/view/slideimage.dart';

class HomeFirst extends StatefulWidget {
  const HomeFirst({super.key});

  @override
  State<HomeFirst> createState() => _HomeFirstState();
}

class _HomeFirstState extends State<HomeFirst> {
  final auth = Get.put(Authcontroller());
  final current = Get.put(CurrentPos());
  final addtocart = FirebaseFirestore.instance.collection('AddCart');
  int qty = 0;
  @override
  Widget build(BuildContext context) {
    // final addtocart = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(auth.userId.value)
    //     .collection('Cart');
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder(
              init: current,
              builder: (controller) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      builder: (context) {
                        return SizedBox(
                          height: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Change delivery location',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.getCurrentLocat();
                                },
                                child: Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: SvgPicture.asset(
                                        'asset/svg/pinlocate.svg',
                                        color: Colors.green,
                                      ),
                                    ),
                                    title: const Text('Current location'),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const MapPage());
                                },
                                child: Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: SvgPicture.asset(
                                        'asset/svg/map.svg',
                                        color: Colors.green,
                                      ),
                                    ),
                                    title: const Text('Choose on map'),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.green,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: SvgPicture.asset(
                                      'asset/svg/addlocal.svg',
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: const Text(
                                    'Create favorite location',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: controller.isloading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(0, 1))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Delivery location',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: Text(
                                        controller.isloading.value
                                            ? 'No location found'
                                            : controller.currentlocal ?? '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.5),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(CartPage());
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      StreamBuilder(
                                        // ignore: unnecessary_null_comparison
                                        stream: auth.isSignedIn.value == true
                                            ? FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(auth.userId.value)
                                                .collection('Cart')
                                                .snapshots()
                                            : addtocart.snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: Text("Loading"),
                                            );
                                          }
                                          if (snapshot.hasError) {
                                            return const Center(
                                              child: Text("Error"),
                                            );
                                          }
                                          return Text(
                                            ' ${snapshot.data!.docs.length}',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          );
                                        },
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
                );
              },
            ),
            //Imagslide
            const SlideIamge(),
            // TextField
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
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
