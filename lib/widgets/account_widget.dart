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

  const AccountWidget({Key key, this.account}) : super(key: key);

  // AccountWidget({this.account, this.onImageChange, this.onIndexChange});

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  void onSomeEvent() {
    // call myMethodIWantToCallFromAnotherWidget from MyWidget
  }

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
            CarouselDemo(
              imageList: widget.account.pics,
            ),

            //todo: I should remove the comment
            /* (widget.account.pics.length == 0
                ? SizedBox(
                    width: 1,
                    height: 1,
                  )
                : Hero(
                    tag: widget.account.title+((i++).toString()),
                    child: Image.network(
                      widget.account.pics[_imageIndex],
                      fit: BoxFit.fill,
                      // style: TextStyle(fontSize: 200),
                      // textAlign: TextAlign.center,
                    ),
                  )
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.account.pics
                    .map(
                      (pic) => GestureDetector(
                        onTap: () =>{
                          _changeCell(widget.account.pics.indexOf(pic)),
                          print(widget.account.pics.indexOf(pic)),



                        },

                        child: Image.network(widget
                            .account.pics[widget.account.pics.indexOf(pic)]),
                      ),
                    )
                    .toList(),
              ),
            ),*/

            Container(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    widget.account.address,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.deepOrange, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.account.hours,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(height: 14),
            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  widget.account.description,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.share,
                        size: 40,
                      ),
                      color: Colors.deepPurple,
                      tooltip: 'Increase volume by 10',
                      onPressed: () => share(context, widget.account)),
                  IconButton(
                      icon: Icon(
                        Icons.call,
                        size: 40,
                      ),
                      color: Colors.green,
                      tooltip: 'Increase volume by 10',
                      onPressed: () => launch("tel:${widget.account.phone}")),
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
