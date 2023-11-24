import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/model/cartlist.dart';
import 'package:pizzaapp/view/categorymenu/DetailPage.dart';

// ignore: must_be_immutable
class CategoriesPageview extends StatefulWidget {
  late int valindex;
  CategoriesPageview({super.key, required this.valindex});

  @override
  State<CategoriesPageview> createState() => _CategoriesPageviewState();
}

class _CategoriesPageviewState extends State<CategoriesPageview> {
  final controllercart = Get.put(cartList());
  CollectionReference product =
      FirebaseFirestore.instance.collection('product');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: product.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return DefaultTabController(
          length: snapshot.data!.docs.length,
          initialIndex: widget.valindex,
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
              title: const Text(
                'Categories',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TabBar(
                        onTap: (value) {
                          setState(() {
                            widget.valindex = value;
                          });
                        },
                        isScrollable: true,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                        tabs:
                            List.generate(snapshot.data!.docs.length, (index) {
                          return Tab(
                            text:
                                // ignore: unnecessary_string_interpolations
                                '${snapshot.data!.docs[index]['type'].toString().tr}',
                          );
                        })),
                  ),
                ),
                Expanded(
                    child: TabBarView(
                        children:
                            List.generate(snapshot.data!.docs.length, (index) {
                  var database = FirebaseFirestore.instance
                      .collection('product')
                      .doc(snapshot.data!.docs[index].id)
                      .collection('data');
                  return StreamBuilder(
                    stream: database.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var datatype = snapshot.data!.docs[index];
                          return InkWell(
                            onTap: () {
                              Get.to(detail(
                                // typeCategories: lsofls[widget.valindex][index],
                                crust: datatype['crust'],
                                sauce: datatype['sauce'],
                                size: datatype['size'],
                                id: datatype['id'],
                                name: datatype['name'],
                                pic: datatype['pic'],
                                pri: double.parse(datatype['price']),
                                qty: datatype['qty'],
                              ));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Hero(
                                    tag: datatype['id'],
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  AssetImage(datatype['pic'])),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8))),
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          datatype['name'],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('\$ ${datatype['price']}',
                                            style: const TextStyle(
                                              fontSize: 17,
                                            ))
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                })))
              ],
            ),
          ),
        );
      },
    );
  }
}
