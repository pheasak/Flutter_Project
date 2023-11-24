import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:pizzaapp/controller/auth_controll.dart';
import 'package:pizzaapp/view/SignUp.dart';
import 'package:pizzaapp/widget/homepage.dart';

class Verify extends StatefulWidget {
  final String verification, phone;
  const Verify({super.key, required this.verification, required this.phone});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  int timeleft = 60, minute = 0;
  final _pinput = TextEditingController();
  final Authcontrl = Get.put(Authcontroller());
  @override
  void initState() {
    // TODO: implement initState
    _starttimer();
    super.initState();
  }

  // set timer
  void _starttimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeleft > 0) {
        setState(() {
          timeleft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultpin = PinTheme(
        width: 50,
        textStyle: const TextStyle(fontSize: 22, color: Colors.black),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white));
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Enter OTP',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Container(
                // alignment: Alignment.center,
                margin: const EdgeInsets.all(20),
                width: double.infinity,

                child: SvgPicture.asset(
                  'asset/svg/verify.svg',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 300,
              child: const Text(
                'Enter the Code we sent to Your Number',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.center,
                width: 300,
                child: Text(
                  widget.phone,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 80,
                child: Pinput(
                  controller: _pinput,
                  animationCurve: Curves.easeInBack,
                  length: 6,
                  defaultPinTheme: defaultpin,
                  focusedPinTheme: defaultpin.copyWith(
                      decoration: defaultpin.decoration!.copyWith(
                          border: Border.all(color: Colors.green, width: 2))),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Resends code',
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    height: 15,
                    width: 15,
                    child: SvgPicture.asset('asset/svg/clock.svg')),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(
                    '${timeleft > 59 ? minute = 1 : 00}' +
                        ':' +
                        '${timeleft > 59 ? 0 : timeleft.toString()}',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green),
                  child: TextButton(
                      onPressed: () async {
                        // confirm code sms  and login
                        Authcontrl.verifycode(
                            code: _pinput.text.toString(),
                            verfiycode: widget.verification,
                            process: () {
                              Authcontrl.checkExistingUser().then((value) {
                                if (value == true) {
                                  Authcontrl.getDataFromFirestore().then(
                                      (value) => Authcontrl.setSignIn().then(
                                          (value) => Authcontrl.storeUserLocal()
                                              .then((value) =>
                                                  Authcontrl.getUserId().then(
                                                      (value) => Get.to(
                                                          PizzaPage())))));
                                } else {
                                  Get.to(() => SignupPage(
                                        phones: widget.phone.toString(),
                                      ));
                                }
                              });
                            });
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
