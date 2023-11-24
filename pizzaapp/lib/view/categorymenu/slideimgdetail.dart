import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../contect/Getqty.dart';

class slidedetail extends StatefulWidget {
  final String pic, name;
  final double pri;
  final int id;
  const slidedetail(
      {super.key,
      required this.name,
      required this.pic,
      required this.pri,
      required this.id});

  @override
  State<slidedetail> createState() => _detailState();
}

class _detailState extends State<slidedetail> {
  @override
  qtycontrol control = qtycontrol();
  int setindex = 0, curtindex = 0, sauceindex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 260,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: widget.id,
                      child: Container(
                        height: 195,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.pic),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '\$ ${widget.pri.toString()}',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.green[800],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'staff',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      )),
                  const Icon(
                    Icons.favorite_border,
                    size: 30,
                  )
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),

          //Crust
          const Text(
            'Crust',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(8, (index) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        curtindex = index; // dynamic
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 60,
                          width: 120,
                          decoration: BoxDecoration(
                              color: curtindex == index
                                  ? Colors.green[900]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 2, color: Colors.green)),
                          child: Text(
                            'Text',
                            style: TextStyle(
                                color:
                                    curtindex == index ? Colors.white : null),
                          ),
                        ),
                        Positioned(
                            top: 15,
                            right: 15,
                            child: curtindex == index
                                ? Container(
                                    height: 15,
                                    width: 15,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.check,
                                      size: 15,
                                      color: Colors.green[900],
                                    ),
                                  )
                                : const Center())
                      ],
                    ));
              }),
            ),
          ),

          // Size
          const Text(
            'Size',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(8, (index) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        setindex = index; // dynamic
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 60,
                          width: 120,
                          decoration: BoxDecoration(
                              color: setindex == index
                                  ? Colors.green[900]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 2, color: Colors.green)),
                          child: Text(
                            'Text',
                            style: TextStyle(
                                color: setindex == index ? Colors.white : null),
                          ),
                        ),
                        Positioned(
                            top: 15,
                            right: 15,
                            child: setindex == index
                                ? Container(
                                    height: 15,
                                    width: 15,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.check,
                                      size: 15,
                                      color: Colors.green[900],
                                    ),
                                  )
                                : const Center())
                      ],
                    ));
              }),
            ),
          ),

          // Sauce
          const Text(
            'Select Sauce',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(8, (index) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        sauceindex = index;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 60,
                          width: 120,
                          decoration: BoxDecoration(
                              color: sauceindex == index
                                  ? Colors.green[900]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 2, color: Colors.green)),
                          child: Text(
                            'Text',
                            style: TextStyle(
                                color:
                                    sauceindex == index ? Colors.white : null),
                          ),
                        ),
                        Positioned(
                            top: 15,
                            right: 15,
                            child: sauceindex == index
                                ? Container(
                                    height: 15,
                                    width: 15,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.check,
                                      size: 15,
                                      color: Colors.green[900],
                                    ),
                                  )
                                : const Center())
                      ],
                    ));
              }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Quantity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                        onPressed: () {
                          control.qtydecreament();
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ))),
                const SizedBox(
                  width: 15,
                ),
                Obx(
                  () => Text(
                    control.counter.value.toString(),
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.green[900],
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                        onPressed: () {
                          control.qtyincreament();
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )))
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(
                      () => Text(
                        'Qty : ${control.counter.value.toString()}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    Obx(() => Text(
                          '\$ ${control.counter.value * widget.pri}',
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green[900]),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
