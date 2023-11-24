// ignore_for_file: avoid_print, duplicate_ignore
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/model/branch.dart';

class CurrentPos extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getCurrentLocat();
    super.onInit();
  }

  Position? currentpostion;
  var isloading = false.obs;
  RxDouble distance = 0.0.obs;
  String? currentlocal;
  RxList<BranchModel> branchList = <BranchModel>[].obs;
  // if there is no location permission then we need that
  Future<Position> getPos() async {
    LocationPermission? permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // get address from lat long
  Future<void> getaddressFromLatlang(long, lat) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
      Placemark place = placemark[0];
      currentlocal = " ${place.street},${place.locality},${place.country}";
      update();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // get current location
  void getCurrentLocat() async {
    try {
      isloading(true);
      update();
      currentpostion = await getPos();
      getaddressFromLatlang(
          currentpostion!.longitude, currentpostion!.latitude);
      isloading(false);
      update();
    } catch (e) {
      print(e);
    }
  }

  // get current camera position
  // Future<CameraPosition> getcameraposition() async {
  //   Position currentPosition = await getPos();
  //   if (currentpostion != null) {
  //     return CameraPosition(
  //         zoom: 13,
  //         target: LatLng(currentPosition.latitude, currentpostion!.longitude));
  //   } else {
  //     throw Exception(
  //         "Error current location because google map permission was denied");
  //   }
  // }

  // get distance between location
  Future<void> getdistance(
      double lat, double lng, double clat, double clng) async {
    isloading.value = true;
    update();
    distance.value = Geolocator.distanceBetween(clat, clng, lat, lng);
    distance.value.round().toInt();
    isloading.value = false;
    update();
  }
}
