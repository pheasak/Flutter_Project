class UserModel {
  String? name;
  String? password;
  String? dob;
  String? phone;
  String? provider;
  String? email;
  String? imageUrl;
  String? uid;

  UserModel(
      {this.name,
      this.password,
      this.dob,
      this.provider,
      this.phone,
      this.imageUrl,
      this.email,
      this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        imageUrl: json['picture']!['data']['url'],
        provider: json['provider'],
        uid: json['id']);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['fullname'],
        password: map['password'],
        dob: map['dob'],
        provider: map['provider'],
        email: map['email'],
        imageUrl: map['imageUrl'],
        phone: map['phone'],
        uid: map['uid']);
  }
  Map<String, dynamic> toMap() {
    return {
      'fullname': name ?? '',
      'password': password ?? '',
      'dob': dob ?? '',
      'phone': phone ?? '',
      'provider': provider ?? '',
      'imageUrl': imageUrl ?? '',
      'email': email ?? '',
      'uid': uid ?? ''
    };
  }
}
