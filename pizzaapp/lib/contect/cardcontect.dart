import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pizzaapp/view/Language.dart';
import 'package:url_launcher/url_launcher.dart';

class Contect extends StatefulWidget {
  final List lscard;
  // ignore: use_key_in_widget_constructors
  const Contect({required this.lscard});

  @override
  State<Contect> createState() => _ContectState();
}

String? image, title;

class _ContectState extends State<Contect> {
  void _openApp() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _url = Uri.parse('https://www.messenger.com/');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.lscard.length, (index) {
        return InkWell(
          onTap: () {
            widget.lscard[index].title == 'Langauge'
                ? Get.to(() => const LanguagePage())
                : widget.lscard[index].title == 'Chat with Us'
                    ? _openApp()
                    : null;
          },
          child: Card(
              borderOnForeground: true,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset(
                    widget.lscard[index].pic,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  widget.lscard[index].title,
                  style: const TextStyle(fontSize: 18),
                ),
                // ignore: sized_box_for_whitespace
                trailing: Container(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'asset/svg/right.svg',
                    )),
              )),
        );
      }),
    );
  }
}
