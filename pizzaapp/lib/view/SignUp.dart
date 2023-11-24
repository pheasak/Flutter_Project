// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/controller/auth_controll.dart';
import 'package:pizzaapp/controller/optionuser.dart';
import 'package:pizzaapp/model/usermodel.dart';
import 'package:pizzaapp/widget/homepage.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key, required this.phones});
  String phones = '';
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool obcur = true, ckecking = false;
  final auth = Get.put(Authcontroller());
  static DateTime? dateTime;
  final optionUser _optionuser = optionUser();
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String cpass = '';
  void _showdatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2030))
        .then((value) {
      setState(() {
        dateTime = value;
      });
    });
  }

  _signupState() {
    if (formkey.currentState!.validate()) {
      if (password != cpass) {
        return Get.showSnackbar(const GetSnackBar(
          title: 'ooops!',
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          message: 'Your passwords isn\'t match',
        ));
      } else {
        final auth = Get.put(Authcontroller());
        UserModel usermodel = UserModel(
            uid: '',
            email: email,
            phone: auth.phonenum.value,
            imageUrl: '',
            dob: '${dateTime!.year}/${dateTime!.month}/${dateTime!.day}',
            name: _userController.text,
            password: password);
        auth.saveUserToFirestore(
            user: usermodel,
            onSuccess: () {
              auth
                  .storeUserLocal()
                  .then((value) => auth.setSignIn())
                  .then((value) => Get.offAll(() => PizzaPage()));
            });
      }
    }
  }

  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        title: const Text('Create account'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: 150,
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: double.infinity,
                  child: SvgPicture.asset('asset/svg/spy.svg'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    controller: _userController,
                    decoration: InputDecoration(
                        hintText: 'User name',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    // controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'Email address',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)
                          ? null
                          : "Please Enter vaild email";
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    obscureText: obcur,
                    // controller: _passwordController,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                if (obcur == true) {
                                  obcur = false;
                                } else {
                                  obcur = true;
                                }
                              });
                            },
                            child: obcur
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        hintText: 'Passwords',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Passwords is must be 6 charecter.';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: _confirmpassController,
                    obscureText: obcur,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                if (obcur == true) {
                                  obcur = false;
                                } else {
                                  obcur = true;
                                }
                              });
                            },
                            child: obcur
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        hintText: 'Confirm passwords',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                    onChanged: (value) {
                      cpass = value;
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Passwords must be 6 charecter.';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    onTap: () {
                      _showdatepicker();
                    },
                    controller: TextEditingController(
                        text: dateTime == null
                            ? null
                            : '${dateTime!.year}/${dateTime!.month}/${dateTime!.day}'),
                    decoration: InputDecoration(
                        hintText: 'Date of birth',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 110,
              ),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: ckecking,
                    onChanged: (value) {
                      setState(() {
                        ckecking = value!;
                      });
                    },
                  ),
                  const Text('I agree with the '),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Term & Condition',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ckecking == true ? Colors.green : Colors.grey),
                  child: TextButton(
                      onPressed: () {
                        ckecking == true ? _signupState() : null;
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
