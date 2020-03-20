import 'package:flutter/cupertino.dart';
import 'package:madayen/model/model.dart';
import 'package:madayen/pages/search_map.dart';
import 'package:madayen/widgets/carousel-widget.dart';
import 'package:madayen/widgets/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

//just a test

class AccountWidget extends StatefulWidget {
  final Account account;

  AccountWidget({this.account});

  // AccountWidget({this.account, this.onImageChange, this.onIndexChange});

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.account.title,
          style: GoogleFonts.almarai(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            widget.account.pics[0] != ''
                ? CarouselDemo(
                    imageList: widget.account.pics,
                  )
                : Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ArabicText(
                            title: widget.account.address,
                            size: 20,
                            color: Colors.red),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ArabicText(
                              title: widget.account.hours,
                              size: 15,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 14),
            Card(
              elevation: 5,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child:
                      ArabicText(title: widget.account.description, size: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                child: Center(
                  child: Text(
                    'للتواصل',
                    style: GoogleFonts.almarai(
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.share,
                            size: 40,
                          ),
                          color: Colors.deepPurple,
                          tooltip: 'Increase volume by 10',
                          onPressed: () => share(context, widget.account)),
                      Text('مشاركة'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.call,
                            size: 40,
                          ),
                          color: Colors.green,
                          tooltip: 'Increase volume by 10',
                          onPressed: () =>
                              launch("tel:${widget.account.phone}")),
                      Text('اتصال'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      widget.account.latLng != null
                          ? IconButton(
                              icon: Icon(
                                Icons.map,
                                size: 40,
                              ),
                              color: Colors.blue,
                              tooltip: 'Increase volume by 10',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyMap(
                                            account: widget.account,
                                          )),
                                );
                              })
                          : IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.map,
                                size: 40,
                              ),
                              color: Colors.grey,
                              tooltip: 'لا يوجد موقع حاليا',
                            ),
                      Text('خريطه'),
                    ],
                  ),

                  /*Text('share')*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget ArabicText({String title, double size, Color color}) {
  return Text(
    title,
    textDirection: TextDirection.rtl,
    style: GoogleFonts.almarai(
      textStyle:
          TextStyle(fontSize: size, color: color, fontWeight: FontWeight.bold),
    ),
  );
}
