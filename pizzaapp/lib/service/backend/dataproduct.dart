class Product {
  String type, pic, size, crust, sauce;
  double price;
  int id, qty;
  Product(
      {required this.qty,
      required this.pic,
      required this.price,
      required this.type,
      required this.id,
      required this.crust,
      required this.sauce,
      required this.size});
  Map<String, dynamic> map() {
    return {
      'id': id,
      'name': type,
      'pic': pic,
      'price': price,
      'qty': qty,
      'crust': crust,
      'size': size,
      'sauce': sauce
    };
  }
}
