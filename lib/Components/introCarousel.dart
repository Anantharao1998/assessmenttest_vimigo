import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class introCarousel extends StatefulWidget {
  const introCarousel({Key? key}) : super(key: key);

  @override
  State<introCarousel> createState() => _introCarouselState();
}

class _introCarouselState extends State<introCarousel> {
  List introList = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/intro.json');
    final data = await json.decode(response);
    setState(() {
      introList = data;
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (introList.isNotEmpty) {
      return CarouselSlider.builder(
        itemCount: introList.length,
        options: CarouselOptions(
          height: 600,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          autoPlay: true,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Image.asset(
                    '${introList[index]["imagePath"]}',
                    height: 500,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${introList[index]["description"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return CircularProgressIndicator();
    }
    debugPrint(introList.toString());
  }
}
