import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/controller/auth_controll.dart';
import 'package:pizzaapp/service/cardmenu.dart';
import 'package:pizzaapp/widget/Login.dart';

import '../contect/cardcontect.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  final authcontrl = Get.put(Authcontroller());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                height: 240,
                width: double.infinity,
              ),
              Positioned(
                top: 60,
                child: Container(
                  height: 180,
                  width: 380,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetBuilder(
                        init: authcontrl,
                        builder: (controller) {
                          // ignore: unrelated_type_equality_checks
                          return authcontrl.isSignedIn == true
                              ? authcontrl.usermodel.value.provider ==
                                      "FACEBOOK"
                                  ? _fbuser
                                  : _dataUserphone
                              : _guest;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder(
                        init: authcontrl,
                        builder: (controller) {
                          return Container(
                            height: 40,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(20)),
                            child: TextButton(
                                onPressed: () {
                                  authcontrl.isSignedIn.value == true
                                      ? authcontrl.signOut()
                                      : Get.to(() => LoginPage());
                                },
                                child: Text(
                                    authcontrl.isSignedIn.value == true
                                        ? 'Sign Out'
                                        : 'Signin/ Sign up',
                                    style:
                                        const TextStyle(color: Colors.black))),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                child: GetBuilder(
                  init: authcontrl,
                  builder: (controller) {
                    return authcontrl.isSignedIn.value == true
                        ? authcontrl.usermodel.value.provider == "FACEBOOK"
                            ? _profilefb
                            : _profileuser
                        : _profileguest;
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // menu card
          Contect(lscard: cardMe.lscm),
          const SizedBox(
            height: 40,
          ),
          //controll
          Contect(lscard: cardMe.lscontrol),
          const SizedBox(
            height: 40,
          ),
          //Notifition
          Contect(lscard: cardMe.lsnoti),
          const SizedBox(
            height: 40,
          ),
          //Notifition
          Contect(lscard: cardMe.lsabouts),
        ]),
      ),
    );
  }

  get _dataUserphone {
    return Column(
      children: [
        Text('${authcontrl.usermodel.value.name}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 5,
        ),
        Text('${authcontrl.usermodel.value.phone}',
            style: const TextStyle(
              fontSize: 18,
            )),
      ],
    );
  }

  get _fbuser {
    return Column(
      children: [
        Text('${authcontrl.usermodel.value.name}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }

  get _guest {
    return Column(
      children: const [
        Text('Guest Account',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }

  get _profileuser {
    return const CircleAvatar(
      radius: 40,
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.person,
        size: 45,
        color: Colors.white,
      ),
    );
  }

  get _profileguest {
    return Container(
      alignment: Alignment.center,
      height: 90,
      width: 90,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: Colors.greenAccent),
      child: const Text(
        'GA',
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    );
  }

  get _profilefb {
    return Container(
      alignment: Alignment.center,
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage('${authcontrl.usermodel.value.imageUrl}'))),
    );
  }
}
