import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/controller/controllang.dart';
import 'package:pizzaapp/service/languagetype.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Global/global.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

final controllerlang = controllerLanguage();
int select = 0;
_uploadLocal(Locale locale) {
  Get.updateLocale(locale);
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  void initState() {
    setState(() {
      getIndex();
    });
  }

  Future setIndex(int ins) async {
    SharedPreferences prefers = await SharedPreferences.getInstance();
    ins;
    await prefers.setInt('Index', ins);
  }

  Future getIndex() async {
    SharedPreferences prefers = await SharedPreferences.getInstance();
    select = prefers.getInt('Index')!;
    _uploadLocal(local[select]['locale']!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Language'),
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(color: Colors.black),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: GetBuilder(
          init: controllerlang,
          builder: (controller) {
            return Column(
              children: List.generate(Logolanguage.lslog.length, (index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        select = index;
                        setIndex(index);
                        Get.updateLocale(local[index]['locale']!);
                      });
                      controllerlang.selectIndex.value = select;
                      controllerlang.changeLanguage(
                          local[controllerlang.selectIndex.value]['locale']!);
                    },
                    title: Text(Logolanguage.lslog[index].lang),
                    trailing: select == index
                        ? Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          )
                        : null,
                    leading: CircleAvatar(
                      child: Image.asset(Logolanguage.lslog[index].logo),
                    ),
                  ),
                );
              }),
            );
          },
        ));
  }
}
