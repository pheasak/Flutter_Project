class TypeCategories {
  String type, pic;
  TypeCategories({
    required this.pic,
    required this.type,
  });
  Map<String, dynamic> map() {
    return {
      'name': type,
      'pic': pic,
    };
  }
}
