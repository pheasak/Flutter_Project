import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/controller/auth_controll.dart';
import 'package:pizzaapp/view/history.dart';
import 'package:pizzaapp/view/profile.dart';
import '../controller/controllang.dart';
import '../view/homaseconds.dart';
import '../view/homefirst.dart';

class PizzaPage extends StatefulWidget {
  PizzaPage({
    super.key,
  });

  @override
  State<PizzaPage> createState() => _PizzaPageState();
}

final authcon = Get.put(Authcontroller());
List<Widget> lswidget = [
  SafeArea(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.green,
                indicator: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                tabs: const [
                  Tab(
                    text: 'DELIVERY',
                  ),
                  Tab(
                    text: 'PICK UP',
                  )
                ]),
          ),
        ),
        Expanded(
            child: TabBarView(children: [
          GetBuilder(
            init: authcon,
            builder: (controller) {
              return const HomeFirst();
            },
          ),
          const HomePageSeconds()
        ]))
      ],
    ),
  ),
  const History(),
  Profile()
];
int tapindex = 0, selectindex = 0;
final controllerlang = controllerLanguage();

class _PizzaPageState extends State<PizzaPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controllerlang,
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          animationDuration: const Duration(milliseconds: 500),
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            body: lswidget[selectindex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 15,
                selectedIconTheme: const IconThemeData(size: 30),
                selectedLabelStyle: const TextStyle(color: Colors.green),
                onTap: (index) {
                  setState(() {
                    selectindex = index;
                    print(selectindex);
                  });
                },
                currentIndex: selectindex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.local_pizza,
                        color: selectindex == 0 ? Colors.green : Colors.grey,
                      ),
                      label: 'Browse'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.history,
                        color: selectindex == 1 ? Colors.green : Colors.grey,
                      ),
                      label: 'History'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        color: selectindex == 2 ? Colors.green : Colors.grey,
                      ),
                      label: 'Profile')
                ]),
          ),
        );
      },
    );
  }
}
