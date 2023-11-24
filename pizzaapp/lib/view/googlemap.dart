import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizzaapp/model/PlaceAutocomplete.dart';
import 'package:pizzaapp/model/autocompletepredection.dart';
import 'package:pizzaapp/service/currentposittion.dart';
import 'package:pizzaapp/view/categorymenu/Locationlist.dart';
import 'package:pizzaapp/view/categorymenu/NetworkUlity.dart';
// import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapCurrentPossition = Get.put(CurrentPos());
  // static const LatLng sourcelocation = LatLng(11.5562, 104.9248);
  static LatLng destination = LatLng(0, 0);
  GoogleMapController? mapController;
  //LocationData? currentlocation;
  @override
  void initState() {
    // TODO: implement initState
    // getCurrentLocation();
    super.initState();
  }

  // void getCurrentLocation() async {
  //   Location location = Location();
  //   location.getLocation().then((location) {
  //     setState(() {
  //       currentlocation = location;
  //     });
  //   });

  //   location.onLocationChanged.listen((newloc) {
  //     setState(() {
  //   sss    currentlocation = newloc;
  //     });
  //   });
  //   print('CurrentLocation: ${currentlocation}');
  // }
  List<AutocompletePredection> placePredection = [];
  void placeAutoComplate(String qery) async {
    Uri uri =
        Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
      "input": qery,
      "key": 'AIzaSyBc0-1E3-5NEdNlNsh7b9Kh8FE5R3yCGEk',
    });
    String? response = await NetworkUltily.fetchUrl(uri);

    if (response != null) {
      PlaceautoResponse results = PlaceautoResponse.placeautoresult(response);
      if (results.prediction != null) {
        setState(() {
          placePredection = results.prediction!;
        });
      }
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrentPos>(
      init: mapCurrentPossition,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            titleTextStyle: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: const Text('Select location'),
            centerTitle: false,
            bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 60),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      padding: const EdgeInsets.all(8),
                      child: Form(
                        child: TextFormField(
                          onTap: () {},
                          onChanged: (value) {
                            placeAutoComplate(value);
                          },
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              hintText: controller.isloading.value
                                  ? 'No location'
                                  : controller.currentlocal),
                        ),
                      ),
                    ),
                    // ListView.builder(
                    //   itemCount: placePredection.length,
                    //   itemBuilder: (context, index) => LocationListTile(
                    //     location: placePredection[index].description!,
                    //     press: () {},
                    //   ),
                    // )
                  ],
                )),
          ),
          body: controller.isloading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GoogleMap(
                  onTap: (LatLng latLng) {
                    print('Latlng:${latLng}');
                    setState(() {
                      destination = latLng;
                      controller.getaddressFromLatlang(
                          latLng.longitude, latLng.latitude);
                    });
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                        controller.currentpostion!.latitude,
                        controller.currentpostion!.longitude,
                      ),
                      zoom: 13.99),
                  mapType: MapType.normal,
                  markers: {
                    // Marker(
                    //     icon: BitmapDescriptor.defaultMarkerWithHue(
                    //         BitmapDescriptor.hueCyan),
                    //     markerId: const MarkerId('CurrentLocation'),
                    //     position: LatLng(
                    //       controller.currentpostion!.latitude,
                    //       controller.currentpostion!.longitude,
                    //     )),
                    Marker(
                        markerId: const MarkerId('Tap location'),
                        position: destination),
                  },
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton(
              elevation: 19,
              backgroundColor: Colors.white,
              onPressed: () async {
                setState(() {
                  destination = LatLng(0, 0);
                  controller.getaddressFromLatlang(
                    controller.currentpostion!.longitude,
                    controller.currentpostion!.latitude,
                  );
                });
                mapController!.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(
                          controller.currentpostion!.latitude,
                          controller.currentpostion!.longitude,
                        ),
                        zoom: 13.99)));
              },
              child: Icon(
                Icons.location_searching_outlined,
                color: Colors.black,
              )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Select Location',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        );
      },
    );
  }
}
