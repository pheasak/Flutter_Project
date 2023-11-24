// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/controller/auth_controll.dart';
import 'package:pizzaapp/controller/cartcontrollerdata.dart';
import '../../contect/Getqty.dart';
import '../../service/backend/dataproduct.dart';

// ignore: camel_case_types
class bundlesdetail extends StatefulWidget {
  final String pic, name;
  final double pri;
  final int id;
  final String detail;
  const bundlesdetail(
      {super.key,
      required this.detail,
      required this.name,
      required this.pic,
      required this.pri,
      required this.id});

  @override
  State<bundlesdetail> createState() => _bundlesdetailState();
}

AddTocart addTocart = AddTocart();
final auth = Get.put(Authcontroller());

// ignore: camel_case_types
class _bundlesdetailState extends State<bundlesdetail> {
  qtycontrol control = qtycontrol();
  int setindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 260,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 195,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.pic),
                              fit: BoxFit.fill)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '\$ ${widget.pri.toString()}',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.green[800],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'staff',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      )),
                  const Icon(
                    Icons.favorite_border,
                    size: 30,
                  )
                ],
              ))
            ],
          ),

          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('bundle')
                  .doc(widget.detail)
                  .collection('item')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('Loading'),
                  );
                }
                return Column(
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    var item = snapshot.data!.docs[index];
                    return Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(item['pic']),
                                    fit: BoxFit.cover),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('\$ ${item['price']}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ))
                              ],
                            ),
                          ))
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          const Text(
            'Quantity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                        onPressed: () {
                          control.qtydecreament();
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ))),
                const SizedBox(
                  width: 15,
                ),
                Obx(
                  () => Text(
                    control.counter.value.toString(),
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.green[900],
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                        onPressed: () {
                          control.qtyincreament();
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )))
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          // add to cart
          Container(
            padding: const EdgeInsets.all(10),
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(
                      () => Text(
                        'Qty : ${control.counter.value.toString()}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    Obx(() => Text(
                          '\$ ${control.counter.value * widget.pri}',
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                InkWell(
                  onTap: () {
                    // ignore: unnecessary_null_comparison
                    auth.userId.value == null
                        ? addTocart.addtoCart(
                            Product(
                                crust: "",
                                sauce: "",
                                size: "",
                                qty: control.counter.value,
                                pic: widget.pic,
                                price: widget.pri,
                                type: widget.name,
                                id: widget.id),
                            auth.userId.value)
                        : addTocart.guestTocart(Product(
                            qty: control.counter.value,
                            pic: widget.pic,
                            price: widget.pri,
                            type: widget.name,
                            id: widget.id,
                            crust: "",
                            sauce: "",
                            size: ""));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.green[900]),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
