import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/model/usermodel.dart';
import 'package:pizzaapp/view/verifycode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Authcontroller extends GetxController {
  Rx<UserModel> usermodel = UserModel().obs;
  RxString userId = ''.obs;
  RxString phonenum = ''.obs;
  RxBool isSignedIn = false.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getUserLocal();
    checkSignedIn();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getUserId() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String userData = s.getString("user_model") ?? '';
    usermodel.value = UserModel.fromMap(json.decode(userData));
    userId.value = usermodel.value.uid!;
    update();
  }

  void checkSignedIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    isSignedIn.value = s.getBool('is_signed') ?? false;
    update();
  }

  // checking user sign
  Future<bool> checkExistingUser() async {
    isLoading.value = true;
    update();
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId.value)
        .get();
    if (snapshot.exists) {
      isLoading.value = false;
      update();
      return true;
    } else {
      isLoading.value = false;
      update();
      return false;
    }
  }

  // get data from firebase
  Future getDataFromFirestore() async {
    isLoading.value = true;
    update();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId.value)
        .get()
        .then((snapshot) {
      usermodel.value =
          UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      userId.value = userId.value;
      update();
    });
    isLoading.value = false;
    update();
  }

  //store user in local (SharePreference)
  Future storeUserLocal() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", json.encode(usermodel.value.toMap()));
  }

  //get user from local
  Future getUserLocal() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String userData = s.getString("user_model") ?? '';
    usermodel.value = UserModel.fromMap(json.decode(userData));
    userId.value = usermodel.value.uid!;
    update();
  }

  //set user signed in
  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signed", true);
    isSignedIn.value = true;
    update();
  }

  Future saveFbDataToFirestore() async {
    isLoading.value = true;
    usermodel.value.provider = "FACEBOOK";
    update();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId.value)
        .set(usermodel.value.toMap());
    isLoading.value = false;
    update();
  }

  // Login with facebook
  Future<void> login() async {
    isLoading.value = true;
    update();
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final String url =
        'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${loginResult.accessToken!.token}';
    final graphResponse = await http.get(Uri.parse(url));
    final profile = jsonDecode(graphResponse.body);
    usermodel.value = UserModel.fromJson(profile);
    update();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    User? user = (await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential))
        .user!;
    userId.value = user.uid;
    usermodel.value.uid = userId.value;
    update();
    // Once signed in, return the UserCredential
    // return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  // Signout
  Future signOut() async {
    isLoading.value = true;
    update();
    await FirebaseAuth.instance.signOut();
    isSignedIn.value = false;
    update();
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signed", false);
    s.remove('user_model');
    isLoading.value = false;
    update();
  }

  //===========================$ Phone $================================
  Future signinwithphone(String phonenumber) async {
    phonenum.value = phonenumber;
    update();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phonenumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Get.to(Verify(
          phone: phonenumber,
          verification: verificationId,
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // save to firebase
  Future<void> saveUserToFirestore(
      {required UserModel user, required Function onSuccess}) async {
    isLoading.value = true;
    update();
    user.uid = userId.value;
    user.phone = phonenum.value;
    user.provider = "PHONE";
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId.value)
        .set(user.toMap())
        .then((value) {
      usermodel.value.uid = userId.value;
      usermodel.value = user;
      onSuccess();
      isLoading.value = false;
      update();
    });
  }

  Future verifycode(
      {required String code, verfiycode, required Function process}) async {
    isLoading.value == false;
    update();
    PhoneAuthCredential creadital =
        PhoneAuthProvider.credential(verificationId: verfiycode, smsCode: code);
    User user =
        (await FirebaseAuth.instance.signInWithCredential(creadital)).user!;
    // ignore: unnecessary_null_comparison
    if (user != null) {
      userId.value = user.uid;
      process();
    }
    isLoading.value = false;
    update();
  }
}
