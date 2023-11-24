
// ignore: camel_case_types
class description {
  final String pic, name;
  final double price;

  description({required this.name, required this.pic, required this.price});
}

class PizzaList {
  final String pic, name;
  final double price;
  final int id;
  final List<description> lspic;
  PizzaList(
      {required this.name,
      required this.pic,
      required this.price,
      required this.lspic,
      required this.id});
  static List<PizzaList> pizzals = [
    PizzaList(
        name: 'Cruchy',
        id: 10,
        pic:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStpKPSiEivkVZjFIU9LyjEQPBkIj6g-hM5kJQbC6oSpOM9xya3AP-P3KxRS3UCHxowFJ0&usqp=CAU',
        price: 25.99,
        lspic: [
          description(
              name: 'Pizza',
              pic:
                  'https://th.bing.com/th/id/R.5f90cb194e6a5c4d47d58e1be0b74de3?rik=DhIooox1LF%2fXbg&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f1%2fPepperoni-Pizza-PNG-Transparent-Image.png&ehk=vCSt%2bp9uBosy5D%2f7jjfPxbbrdaeCz%2fCDeuJpBhCC%2fhM%3d&risl=&pid=ImgRaw&r=0',
              price: 10.50),
          description(
              name: 'Fried potato',
              pic:
                  'https://www.seekpng.com/png/detail/834-8346546_french-fries-45-french-fries.png',
              price: 2.5),
          description(
              name: 'Salad',
              pic:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4XIQgdpWokHgrg8xuNj_vliCvSM50GyHLWQ&usqp=CAU',
              price: 6.5),
          description(
              name: 'noodle',
              pic:
                  'https://th.bing.com/th/id/R.0b7129d20ac9acfed54004acfb7a1c9f?rik=15jQ%2bYsfVztnpA&pid=ImgRaw&r=0',
              price: 6.99),
        ]),
    PizzaList(
        name: 'Express',
        id: 20,
        pic:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlGt8kaqpeZCBzPAgtFewAK8kOkmWhscwPqKfWwU6dlWN9O3YvCTl7hDuqVH8qMdhdmVU&usqp=CAU',
        price: 3.99,
        lspic: [
          description(
              name: 'Pizza',
              pic:
                  'https://th.bing.com/th/id/OIP.eNSbKtkaQ2XG6sPGTG0UrAAAAA?pid=ImgDet&w=300&h=300&rs=1',
              price: 3.99)
        ]),
    PizzaList(
        name: 'Spacy',
        id: 30,
        pic:
            'https://scontent.fpnh7-1.fna.fbcdn.net/v/t1.6435-9/64328673_2657953097567897_1892842312694759424_n.jpg?stp=dst-jpg_p843x403&_nc_cat=101&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeErzXA-AKZom6wuKp8VJ8dA5Tx7vWKH0h7lPHu9YofSHmBWuW6wy6iuil0ru43WcPnOeQM2umwxrxA7Hw0OBMvU&_nc_ohc=QcNPJEDChYkAX_NtuIM&_nc_ht=scontent.fpnh7-1.fna&oh=00_AfDD8UHNX0cLIZsOzsB4xBUSwuxmwScpt9Mp5S6KCODF0Q&oe=648FB855',
        price: 9.9,
        lspic: [
          description(
              name: 'Pizza',
              pic:
                  'https://th.bing.com/th/id/OIP.GF144IzKvwcNkbUNg3HDMwAAAA?pid=ImgDet&w=300&h=300&rs=1',
              price: 6.0),
          description(
              name: 'Fried Chicken',
              pic:
                  'https://w7.pngwing.com/pngs/450/98/png-transparent-crispy-fried-chicken-mcdonald-s-chicken-mcnuggets-kfc-fried-chicken.png',
              price: 3.99)
        ]),
    PizzaList(
        name: 'Super offer set',
        id: 41,
        pic:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYM4eIBO0MEdSiQ_6q40Vk2Jh8SnKV1ED41NQGXp59hTD6AmWa4vT-fPpxNGzu4xinypo&usqp=CAU',
        price: 18.50,
        lspic: [
          description(
              name: 'Pizza Spacy',
              pic:
                  'https://th.bing.com/th/id/OIP.1gj6qiafv0QzHk1JPev_MgHaFN?pid=ImgDet&rs=1',
              price: 8),
          description(
              name: 'Pzza hot dog',
              pic:
                  'https://th.bing.com/th/id/OIP.X5DLGU5qXE1H1Y4b4LdN4wHaDv?pid=ImgDet&rs=1',
              price: 7),
          description(
              name: 'Fried',
              pic:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJAGlg2xVmBQM2Uasdhr569iRxmURA1SrKuw&usqp=CAU',
              price: 3),
          description(
              name: 'Coke',
              pic:
                  'https://th.bing.com/th/id/OIP.dchSuzlpyyInEb7xbZrAtgHaHa?pid=ImgDet&rs=1',
              price: 0.5),
        ])
  ];
}
