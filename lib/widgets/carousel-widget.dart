import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final Widget placeholder = Container(color: Colors.grey);

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselDemo extends StatefulWidget {
  final List imageList;

  CarouselDemo({Key key, this.imageList}) : super(key: key);

  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  int _current = 0;

  @override
  void initState() {
    _current = widget.imageList.length - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Manually operated Carousel

    //Button controlled carousel
    Widget buttonDemo() {
      final basicSlider = CarouselSlider(
        items: map<Widget>(
          widget.imageList,
          (index, i) {
            return Container(
              margin: EdgeInsets.all(3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(children: <Widget>[
                  CachedNetworkImage(
                      imageUrl: i, fit: BoxFit.cover, width: 1000.0),
                ]),
              ),
            );
          },
        ).toList(),
        autoPlay: true,
        reverse: true,
        autoPlayInterval: Duration(seconds: 5),
        enlargeCenterPage: true,
        viewportFraction: 0.92,
        aspectRatio: 1.4,
        initialPage: 0,
        onPageChanged: (index) {
          setState(() {
            _current = widget.imageList.length - index - 1;
          });
        },
      );
      return Column(children: [
        basicSlider,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(
            widget.imageList,
            (index, url) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4)),
              );
            },
          ),
        ),
        Container(
          height: 100, // the height of listview important
          child: ListView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              children: widget.imageList
                  .map(
                    (value) => GestureDetector(
                      onTap: () => onPageChange(
                          basicSlider, widget.imageList.indexOf(value)),
                      child: Card(
                        elevation: 3,
                        child: CachedNetworkImage(
                          imageUrl: value,
                        ),
                      ),
                    ),
                  )
                  .toList()),
        ),
      ]);
    }

    return buttonDemo();
  }

  onPageChange(basicSlider, pageIndex) {
    basicSlider.animateToPage(pageIndex,
        duration: Duration(milliseconds: 600), curve: Curves.linear);
  }
}
