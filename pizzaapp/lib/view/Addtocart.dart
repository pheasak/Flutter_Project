// ignore_for_file: file_names, must_be_immutable, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizzaapp/controller/auth_controll.dart';
import 'package:pizzaapp/controller/cartcontrollerdata.dart';
import 'package:pizzaapp/service/backend/dataproduct.dart';
import 'package:pizzaapp/service/currentposittion.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key, this.qty});
  int? qty;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int setindex = 0;
  int qty = 0;
  double total = 0;
  bool check = false, checkcount = false;
  DateTime? dateTime = DateTime.now();
  final auth = Get.put(Authcontroller());
  final AddTocart _addTocart = AddTocart();
  final guest = FirebaseFirestore.instance.collection('AddCart');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 19),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Delivery cart'),
        actions: [
          StreamBuilder(
            stream: auth.isSignedIn.value == true
                ? FirebaseFirestore.instance
                    .collection('users')
                    .doc(auth.userId.value)
                    .collection('Cart')
                    .snapshots()
                : guest.snapshots(),
            builder: (context, snapshot) {
              return TextButton(
                  onPressed: () {
                    setState(() {
                      check = true;
                    });
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      auth.userId.value == null
                          ? _addTocart.deleteCart(
                              snapshot.data!.docs[i], auth.userId.value)
                          : _addTocart.deleteguest(snapshot.data!.docs[i]);
                    }
                  },
                  child: const Text(
                    'clear',
                    style: TextStyle(color: Colors.red),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 230,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              decoration: BoxDecoration(color: Colors.green[900]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'You can expect your delivery',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Today at ${dateTime!.hour}:${dateTime!.minute} PM',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    height: 145,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: GetBuilder(
                      init: CurrentPos(),
                      builder: (controller) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 90,
                              child: controller.isloading.value
                                  ? null
                                  : GoogleMap(
                                      onTap: (argument) {},
                                      scrollGesturesEnabled: false,
                                      initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                            controller.currentpostion!.latitude,
                                            controller
                                                .currentpostion!.longitude,
                                          ),
                                          zoom: 13.99),
                                      mapType: MapType.normal,
                                      zoomControlsEnabled: false,
                                      markers: {
                                        Marker(
                                            markerId: const MarkerId(
                                                'CurrentLocation'),
                                            position: LatLng(
                                              controller
                                                  .currentpostion!.latitude,
                                              controller
                                                  .currentpostion!.longitude,
                                            ))
                                      },
                                    ),
                            ),
                            Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(5),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Your location',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    controller.isloading.value
                                        ? 'No location found'
                                        : controller.currentlocal!,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 28,
                          width: 130,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            'Change location',
                            style: TextStyle(color: Colors.green[900]),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 90,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    offset: Offset(0, 1), blurRadius: 5, color: Colors.grey)
              ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Delivery instruction'),
                  Row(
                    children: List.generate(3, (index) {
                      return InkWell(
                          onTap: () {
                            setState(() {
                              setindex = index;
                            });
                            total = 0.0;
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                alignment: Alignment.center,
                                height: 35,
                                width: 110,
                                decoration: BoxDecoration(
                                    color: setindex == index
                                        ? Colors.green[900]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        width: 2, color: Colors.green)),
                                child: Text(
                                  'Text',
                                  style: TextStyle(
                                      color: setindex == index
                                          ? Colors.white
                                          : null),
                                ),
                              ),
                              Positioned(
                                  top: 5,
                                  right: 15,
                                  child: setindex == index
                                      ? Container(
                                          height: 15,
                                          width: 15,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.check,
                                            size: 15,
                                            color: Colors.green[900],
                                          ),
                                        )
                                      : const Center())
                            ],
                          ));
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: auth.isSignedIn.value == true
                  ? FirebaseFirestore.instance
                      .collection('users')
                      .doc(auth.userId.value)
                      .collection('Cart')
                      .snapshots()
                  : guest.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('No Product'),
                  );
                }
                return Container(
                  padding: const EdgeInsets.all(8),
                  // height: 140,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your order',
                        style: TextStyle(fontSize: 17.5),
                      ),
                      Column(
                        children:
                            List.generate(snapshot.data!.docs.length, (index) {
                          var datatype = snapshot.data!.docs[index];
                          total = total + (datatype['price'] * datatype['qty']);
                          return SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(datatype['name']),
                                const Spacer(),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _addTocart.deleteCart(
                                            datatype, auth.userId.value);
                                        _addTocart.deleteguest(datatype);
                                        total = 0;
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.redAccent
                                                .withOpacity(0.4)),
                                        child: const Icon(
                                          Icons.delete_forever_outlined,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        auth.isSignedIn.value == true
                                            ? _addTocart.updateCart(
                                                Product(
                                                    crust: datatype['crust'],
                                                    sauce: datatype['sauce'],
                                                    size: datatype['size'],
                                                    qty: (datatype['qty'] - 1) <
                                                            1
                                                        ? 1
                                                        : datatype['qty'] - 1,
                                                    pic: datatype['pic'],
                                                    price: datatype['price'],
                                                    type: datatype['name'],
                                                    id: datatype['id']),
                                                datatype,
                                                auth.userId.value)
                                            : _addTocart.updateguest(
                                                Product(
                                                    crust: datatype['crust'],
                                                    sauce: datatype['sauce'],
                                                    size: datatype['size'],
                                                    qty: (datatype['qty'] - 1) <
                                                            1
                                                        ? 1
                                                        : datatype['qty'] - 1,
                                                    pic: datatype['pic'],
                                                    price: datatype['price'],
                                                    type: datatype['name'],
                                                    id: datatype['id']),
                                                datatype);
                                        total = 0;
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.red[800]),
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${datatype['qty']}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        auth.isSignedIn.value == true
                                            ? _addTocart.updateCart(
                                                Product(
                                                    crust: datatype['crust'],
                                                    sauce: datatype['sauce'],
                                                    size: datatype['size'],
                                                    qty: (datatype['qty'] + 1) <
                                                            1
                                                        ? 1
                                                        : datatype['qty'] + 1,
                                                    pic: datatype['pic'],
                                                    price: datatype['price'],
                                                    type: datatype['name'],
                                                    id: datatype['id']),
                                                datatype,
                                                auth.userId.value)
                                            : _addTocart.updateguest(
                                                Product(
                                                    crust: datatype['crust'],
                                                    sauce: datatype['sauce'],
                                                    size: datatype['size'],
                                                    qty: (datatype['qty'] + 1) <
                                                            1
                                                        ? 1
                                                        : datatype['qty'] + 1,
                                                    pic: datatype['pic'],
                                                    price: datatype['price'],
                                                    type: datatype['name'],
                                                    id: datatype['id']),
                                                datatype);
                                        total = 0;
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.green[800]),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '\$ ${datatype['price']}',
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(-1, 1),
                              color: Colors.grey,
                              blurRadius: 2)
                        ]),
                    child: Text(
                      'Apply coupon code',
                      style: TextStyle(color: Colors.green[800]),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Summary',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sub total',
                              style: TextStyle(fontSize: 15),
                            ),
                            StreamBuilder(
                              stream: auth.isSignedIn.value == true
                                  ? FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(auth.userId.value)
                                      .collection('Cart')
                                      .snapshots()
                                  : guest.snapshots(),
                              builder: (context, snapshot) {
                                return Text(
                                  'Include 10% VAT(\$ ${total * (10 / 100)})',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                );
                              },
                            )
                          ],
                        ),
                        StreamBuilder(
                          stream: auth.isSignedIn.value == true
                              ? FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(auth.userId.value)
                                  .collection('Cart')
                                  .snapshots()
                              : guest.snapshots(),
                          builder: (context, snapshot) {
                            return Text('\$ ${!check ? total : 0}');
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.all(11),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22), topRight: Radius.circular(22))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Payment methods',
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  'Change',
                  style: TextStyle(color: Colors.green[900], fontSize: 17),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                      height: 30,
                      width: 60,
                      color: Colors.green,
                      child: const Icon(
                        Icons.monetization_on,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Cash on delivery',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Pay by cash',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ),
            StreamBuilder(
                stream: auth.isSignedIn.value == true
                    ? FirebaseFirestore.instance
                        .collection('users')
                        .doc(auth.userId.value)
                        .collection('Cart')
                        .snapshots()
                    : guest.snapshots(),
                builder: (context, snapshot) {
                  return InkWell(
                    onTap: () {
                      // setState(() {
                      //   check = true;
                      // });
                      // for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      //   _addTocart.deleteCart(snapshot.data!.docs[i]);
                      // }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.green[900],
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'Payment',
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
