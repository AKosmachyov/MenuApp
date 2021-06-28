import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Details")),
      child: CarouselSlider.builder(
        itemCount: 2,
        options: CarouselOptions(height: MediaQuery.of(context).size.height),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          Widget child = Text('');
          if (index == 0) {
            child = Text(
              'Developer: Alexander Kosmachyov',
              style: TextStyle(color: Colors.black),
            );
          } else {
            child = Text('Contact email: a.kosmachyov@gmail.com');
          }
          return Container(
            child: Center(child: child),
          );
        },
      ),
    );
  }
}
