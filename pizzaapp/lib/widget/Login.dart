import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/controller/auth_controll.dart';
import 'package:pizzaapp/service/Loginpage.dart';
import 'package:pizzaapp/view/Phone.dart';
import 'package:pizzaapp/view/SignUp.dart';
import 'package:pizzaapp/widget/homepage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int changindex = 0;
  final authcon = Get.put(Authcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ))
            ],
          ),
          SizedBox(
            height: 490,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView(
                  allowImplicitScrolling: false,
                  onPageChanged: (value) {
                    setState(() {
                      changindex = value;
                    });
                  },
                  children: List.generate(Steplogin.steplist.length, (index) {
                    return Container(
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 220,
                            width: 220,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                                Steplogin.steplist[index].icon),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            Steplogin.steplist[index].title,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 300,
                            child: Text(
                              Steplogin.steplist[index].subtitle,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 17),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
                Positioned(
                    left: 170,
                    bottom: 170,
                    child: Row(
                      children:
                          List.generate(Steplogin.steplist.length, (index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: changindex == index
                                  ? Colors.black
                                  : Colors.grey),
                        );
                      }),
                    ))
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(
            height: 20,
          ),
          // bottom
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7), color: Colors.blue),
              child: TextButton(
                  onPressed: () {
                    authcon
                        .login()
                        .then((value) => authcon.checkExistingUser())
                        .then((value) => {
                              if (value == true)
                                {
                                  authcon.getDataFromFirestore().then((value) =>
                                      authcon.storeUserLocal().then((value) =>
                                          authcon.getUserLocal().then((value) =>
                                              authcon.setSignIn().then(
                                                  (value) =>
                                                      authcon.getUserId()))))
                                }
                              else
                                {
                                  authcon.saveFbDataToFirestore().then(
                                      (value) => authcon.storeUserLocal().then(
                                          (value) => authcon
                                              .getUserLocal()
                                              .then((value) => authcon
                                                  .setSignIn()
                                                  .then((value) =>
                                                      authcon.getUserId()))))
                                }
                            });
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.facebook_outlined,
                          color: Colors.white,
                          size: 35,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Continues with Facebook',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7), color: Colors.green),
              child: TextButton(
                  onPressed: () {
                    Get.to(LoginPhone());
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 35,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Continues with Phone Number',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.green),
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white),
              child: TextButton(
                  onPressed: () {
                    Get.off(PizzaPage());
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.person,
                          color: Colors.green,
                          size: 35,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'CONTINUE AS GUEST',
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('don\'t have a account?'),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.green),
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
