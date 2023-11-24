// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/view/search.dart';

class mytext extends StatelessWidget {
  const mytext({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        // showSearch(context: context, delegate: Searchproduct());
        Get.to(() => const Searchproduct());
      },
      showCursor: false,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10)),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Search Food,Drink, Cuisines',
          prefixIcon: const Icon(Icons.search_sharp)),
    );
  }
}
