import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/controller/controllang.dart';
import 'package:pizzaapp/view/categorymenu/pagecategory.dart';

class Categories extends StatelessWidget {
  final controllerl = controllerLanguage();
  Categories({super.key});
  @override
  Widget build(BuildContext context) {
    final CollectionReference product =
        FirebaseFirestore.instance.collection('product');
    return GetBuilder(
      init: controllerl,
      builder: (controller) {
        return StreamBuilder<QuerySnapshot<Object?>>(
          stream: product.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var ty = snapshot.data!.docs;
            return Column(
              children: List.generate(ty.length, (index) {
                var pro = ty[index];
                return InkWell(
                  onTap: () {
                    Get.to(CategoriesPageview(
                      valindex: index,
                    ));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(pro['type'].toString().tr),
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(pro['pic'].toString()),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        );
      },
    );
  }
}
