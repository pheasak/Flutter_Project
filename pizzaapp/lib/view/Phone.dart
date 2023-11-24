import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:pizzaapp/controller/auth_controll.dart';

class LoginPhone extends StatefulWidget {
  LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  @override
  Widget build(BuildContext context) {
    final _phonenumber = TextEditingController();
    bool checking = false, btncolor = false;
    String codecountry = '+855';
    final auth = Get.put(Authcontroller());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black),
        title: const Text(
          "Enter phone number",
          style: TextStyle(fontSize: 19),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 180,
            child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: SvgPicture.asset('asset/svg/number.svg'),
            ),
          ),
          const Text(
            'Enter your phone number',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'we will send a code to this number ',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: const Text(
                    '+855',
                    style: TextStyle(fontSize: 19),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    onChanged: (value) {
                      value.length > 8 ? btncolor = true : btncolor;
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: _phonenumber,
                    decoration: InputDecoration(
                        hintText: 'Phone number',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.white))),
                  ),
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: btncolor == true
                      ? Colors.green
                      : Colors.grey.withOpacity(0.4),
                ),
                child: TextButton(
                    onPressed: () async {
                      // Sign in number phone
                      if (_phonenumber.length < 9) {
                        checking = true;
                      }
                      auth.signinwithphone(codecountry + _phonenumber.text);
                      // auth.signinwithphone(_phonenumber.text);
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
