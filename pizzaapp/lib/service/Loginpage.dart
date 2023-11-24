// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

class Steplogin {
  final String icon, title, subtitle;
  Steplogin({required this.icon, required this.subtitle, required this.title});
  static List<Steplogin> steplist = [
    Steplogin(
      icon: 'asset/svg/food.svg',
      title: 'One App to Order Them All',
      subtitle:
          'Order all favorite brands and have them delivered at the same time',
    ),
    Steplogin(
      icon: 'asset/svg/order.svg',
      title: 'Free Delivery',
      subtitle:
          'Never pay for delivery again with our always-free delivery service',
    ),
    Steplogin(
      icon: 'asset/svg/deliver.svg',
      title: 'Delivered within 45 minute',
      subtitle: 'We deliver to your door in 45 minutes or less, every time!',
    )
  ];
}
