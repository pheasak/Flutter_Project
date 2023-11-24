// ignore: camel_case_types
class cardMe {
  final String title, pic;
  cardMe({required this.pic, required this.title});
  static List<cardMe> lscm = [
    cardMe(pic: 'asset/svg/phone.svg', title: 'Call customer support'),
    cardMe(pic: 'asset/svg/message.svg', title: 'Chat with Us'),
    cardMe(pic: 'asset/svg/mail.svg', title: 'Email Us'),
  ];

  static List<cardMe> lscontrol = [
    cardMe(pic: 'asset/svg/locate.svg', title: 'My delivery location'),
    cardMe(pic: 'asset/svg/lock.svg', title: 'Change passwords'),
    cardMe(pic: 'asset/svg/clock.svg', title: 'Oder history'),
    cardMe(pic: 'asset/svg/lang.svg', title: 'Langauge')
  ];

  static List<cardMe> lsnoti = [
    cardMe(pic: 'asset/svg/noti.svg', title: 'Notification'),
    cardMe(pic: 'asset/svg/favoritr.svg', title: 'Favorite'),
  ];

  static List<cardMe> lsabouts = [
    cardMe(pic: 'asset/svg/share.svg', title: 'Share the app'),
    cardMe(pic: 'asset/svg/clip.svg', title: 'About TPCAPP'),
    cardMe(pic: 'asset/svg/clip.svg', title: 'tearm & Condition'),
  ];
}
