// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/service/usersignup.dart';
import 'package:pizzaapp/widget/homepage.dart';

// ignore: camel_case_types
class optionUser {
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('user');
  // Create User sign Up
  Future createUser(userSignUp user) async {
    await _user.add(user.tomap());
    Get.snackbar('Pizza App', 'Your account is create successfull..!',
        backgroundColor: Colors.white);
    Get.to(() => PizzaPage());
  }

  // Update User sign Up
  // ignore: non_constant_identifier_names
  Future UpdateUser(userSignUp user, DocumentSnapshot documentSnapshot) async {
    await _user.doc(documentSnapshot.id).update(user.tomap());
  }

  // Delete User sign Up
  Future DeleteUser(DocumentSnapshot documentSnapshot) async {
    await _user.doc(documentSnapshot.id).delete();
  }
}
