import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/view/categorymenu/Bundlesdatail.dart';

import '../service/product.dart';

class RowProduct extends StatelessWidget {
  const RowProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final bundle = FirebaseFirestore.instance.collection('bundle');
    return SizedBox(
        height: 200,
        width: double.infinity,
        child: StreamBuilder(
          stream: bundle.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var datatype = snapshot.data!.docs[index];
                return InkWell(
                  onTap: () {
                    Get.to(bundlesdetail(
                        detail: snapshot.data!.docs[index].id,
                        name: datatype['name'],
                        pic: datatype['pic'],
                        pri: double.parse(datatype['price']),
                        id: datatype['id']));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 200,
                    width: 280,
                    //decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 140,
                          width: 280,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(3, 3),
                                    color: Colors.grey,
                                    blurRadius: 2)
                              ],
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(datatype['pic']),
                                  fit: BoxFit.fill)),
                        ),
                        Text(
                          datatype['name'],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$ ${datatype['price']}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
