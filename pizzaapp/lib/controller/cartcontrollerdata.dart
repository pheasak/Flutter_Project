import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizzaapp/service/backend/dataproduct.dart';

class AddTocart {
  final guestcart = FirebaseFirestore.instance.collection('AddCart');

  //Create
  Future addtoCart(
    Product pro,
    String uid,
  ) async {
    CollectionReference addtocart = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Cart");
    // DocumentSnapshot doc = await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(uid)
    //     .collection('Cart')
    //     .doc(pid)
    //     .get();
    // ignore: unnecessary_null_comparison
    // if (doc.exists) {
    //   addtocart
    //       .doc(documentSnapshot.id)
    //       .update({"qty": FieldValue.increment(qty)});
    // }else{
    //   await addtocart.add(pro.map());
    // }
    await addtocart.add(pro.map());
  }

  Future guestTocart(Product pro) async {
    await guestcart.add(pro.map());
  }

  //Update
  Future updateCart(
      Product product, DocumentSnapshot documentSnapshot, String uid) async {
    final CollectionReference addtocart = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Cart");
    // ignore: unnecessary_null_comparison
    await addtocart.doc(documentSnapshot.id).update(product.map());
  }

  Future updateguest(Product product, DocumentSnapshot documentSnapshot) async {
    await guestcart.doc(documentSnapshot.id).update(product.map());
  }

  // delete
  Future deleteCart(DocumentSnapshot documentSnapshot, String uid) async {
    final CollectionReference addtocart = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Cart");
    // ignore: unnecessary_null_comparison
    await addtocart.doc(documentSnapshot.id).delete();
  }

  Future deleteguest(DocumentSnapshot documentSnapshot) async {
    await guestcart.doc(documentSnapshot.id).delete();
  }
}
