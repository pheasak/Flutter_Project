import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/view/categorymenu/DetailPage.dart';

class Searchproduct extends StatefulWidget {
  const Searchproduct({super.key});

  @override
  State<Searchproduct> createState() => _SearchproductState();
}

class _SearchproductState extends State<Searchproduct> {
  String name = '';
  int a = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Card(
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search'),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('allproducts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: avoid_print
            print(snapshot.error);
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text('Loading'),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var datatype = snapshot.data!.docs[index];
                if (datatype['name']
                    .toString()
                    .toLowerCase()
                    .startsWith(name.toLowerCase())) {
                  return InkWell(
                    onTap: () {
                      Get.to(detail(
                          crust: datatype['crust'],
                          sauce: datatype['sauce'],
                          size: datatype['size'],
                          qty: datatype['qty'],
                          name: datatype['name'],
                          pic: datatype['pic'],
                          pri: double.parse(datatype['price']),
                          id: datatype['id']));
                    },
                    child: ListTile(
                      leading: Hero(
                        tag: datatype['id'],
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(datatype['pic']),
                        ),
                      ),
                      title: Text(datatype['name']),
                    ),
                  );
                }
                if (name.isEmpty) {
                  return InkWell(
                    onTap: () {
                      Get.to(detail(
                          crust: datatype['crust'],
                          sauce: datatype['sauce'],
                          size: datatype['size'],
                          qty: datatype['qty'],
                          name: datatype['name'],
                          pic: datatype['pic'],
                          pri: double.parse(datatype['price']),
                          id: datatype['id']));
                    },
                    child: ListTile(
                      leading: Hero(
                        tag: datatype['id'],
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(datatype['pic']),
                        ),
                      ),
                      title: Text(datatype['name']),
                    ),
                  );
                }
                return Container();
              });
        },
      ),
    );
  }
}
