import 'package:cloud_firestore/cloud_firestore.dart';

class BranchModel {
  String? id;
  String? name;
  double? lat;
  double? long;

  BranchModel({this.id, this.name, this.lat, this.long});

  BranchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    long = json['lang'];
  }

  BranchModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot.data() as Map<String, dynamic>);

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'lat': lat, 'lang': long};
  }
}
