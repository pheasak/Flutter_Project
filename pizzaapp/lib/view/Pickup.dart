// ignore_for_file: avoid_print, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizzaapp/service/currentposittion.dart';

class PickUpLocal extends StatefulWidget {
  const PickUpLocal({super.key});

  @override
  State<PickUpLocal> createState() => _PickUpLocalState();
}

final cur = Get.put(CurrentPos());
GoogleMapController? mapController;
double? lat, long;
List<Marker> marker = [];
var locale;
final des = FirebaseFirestore.instance.collection('destination');

class _PickUpLocalState extends State<PickUpLocal> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables

    return StreamBuilder(
      stream: des.snapshots(),
      builder: (context, snapshot) {
        return GetBuilder(
          init: cur,
          builder: (controller) {
            List.generate(snapshot.data!.docs.length, (index) {
              locale = snapshot.data!.docs[index];

              marker.add(Marker(
                  onTap: () {
                    // _buildBottomsheet(locale['name']);
                    cur.getdistance(
                        locale['lat'],
                        locale['lang'],
                        cur.currentpostion!.latitude,
                        cur.currentpostion!.longitude);
                    Get.bottomSheet(BottomSheet(
                      onClosing: () {},
                      builder: (context) {
                        return SizedBox(
                          height: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 10),
                                child: Text(
                                  locale['name'],
                                  style: const TextStyle(fontSize: 19),
                                ),
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  '${(cur.distance.value / 1000000).toStringAsFixed(2)}km away',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: double.infinity,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green[900]),
                                child: const Text(
                                  'START ORDER',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ));
                  },
                  markerId: const MarkerId('Company desition'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  position: LatLng(locale['lang'], locale['lat'])));
            });
            return Scaffold(
              appBar: AppBar(
                elevation: 1,
                iconTheme: const IconThemeData(color: Colors.black),
                titleTextStyle:
                    const TextStyle(color: Colors.black, fontSize: 18),
                backgroundColor: Colors.white,
                title: const Text('Pickup outlets'),
              ),
              body: controller.isloading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                            controller.currentpostion!.latitude,
                            controller.currentpostion!.longitude,
                          ),
                          bearing: 10,
                          zoom: 14.99),
                      zoomControlsEnabled: true,
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                        });
                      },
                      markers: Set.from(marker),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                    ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniEndFloat,
              floatingActionButton: FloatingActionButton(
                  elevation: 19,
                  backgroundColor: Colors.green[900],
                  // ignore: duplicate_ignore
                  onPressed: () async {
                    mapController!.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(
                              controller.currentpostion!.latitude,
                              controller.currentpostion!.longitude,
                            ),
                            zoom: 13.99)));
                  },
                  child: const Icon(
                    Icons.location_on_outlined,
                    size: 30,
                  )),
            );
          },
        );
      },
    );
  }

  // _buildBottomsheet(String name) {
  //   return GetBuilder(
  //     init: cur,
  //     builder: (controller) {
  //       return cur.isloading.value == false
  //           ? SizedBox(
  //               height: 110,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.only(left: 10.0),
  //                     child: Text(name),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(left: 10.0),
  //                     child: Text(
  //                         '${(cur.distance.value / 1000).toStringAsFixed(2)}km away'),
  //                   ),
  //                   Container(
  //                     height: 50,
  //                     width: double.infinity,
  //                     alignment: Alignment.center,
  //                     margin: const EdgeInsets.all(10),
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(5),
  //                         color: Colors.green[900]),
  //                     child: const Text(
  //                       'START ORDER',
  //                       style: TextStyle(color: Colors.white, fontSize: 18),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             )
  //           : Center(
  //               child: Text(
  //                 'loading',
  //                 style: TextStyle(color: Colors.red),
  //               ),
  //             );
  //     },
  //   );
  // }
}
