import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/view/categorymenu/slideimgdetail.dart';

class SlideIamge extends StatefulWidget {
  const SlideIamge({super.key});

  @override
  State<SlideIamge> createState() => _SlideIamgeState();
}

class _SlideIamgeState extends State<SlideIamge> {
  List im = [
    'https://foodbuzz.site/api/v1/files/29B1CF6D-97EF-4AB4-95D5-20609561AAAA',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSifEUDeAgecP3MZo0phes6y9j8Reu7vLdT11XEWYXzhKhgA7kvbIE_Qxc6ZB6jeQiiHDM&usqp=CAU',
    'https://th.bing.com/th/id/OIP.sk0SXKOzWsC6JwVs9ZnP6gHaHa?pid=ImgDet&rs=1',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1FpeZBGEPUvPEn0Xk5l60-JKoeU0MMh7SQptP2wn65fjVZP_gEtCIC17DSlBD0XZdJTw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGL09RIUcy1dUIGGqp6oODSZ1KG3DZhswvMg&usqp=CAU'
  ];

  List<String> lsname = [
    'Luch set',
    'Smart set',
    'Take away set',
    'Spacail set',
    'Promotion'
  ];

  List<double> pirlis = [20, 12, 24, 14, 6];

  List<int> lsid = [1, 2, 3, 4, 5];

  int tpindex = 0;

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      isLoop: true,
      autoPlayInterval: 5000,
      children: List.generate(im.length, (index) {
        return InkResponse(
          onTap: () {
            setState(() {
              tpindex = index;
            });
            Get.to(slidedetail(
                name: lsname[index],
                pic: im[index],
                pri: pirlis[index],
                id: lsid[index]));
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            height: 200,
            width: 290,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: NetworkImage(im[index]), fit: BoxFit.fill)),
          ),
        );
      }),
    );
  }
}
