import 'package:cached_network_image/cached_network_image.dart';
import 'package:madayen/model/model.dart';
import 'package:madayen/widgets/search-widget.dart';
import 'package:madayen/widgets/section_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sections = ItemsBuilder().build(); // get the data from model file

    return GridView.count(
      crossAxisCount: 3,
      children: sections
          .map(
            (section) => GestureDetector(
              onTap: () {
                // print(sections.indexOf(section).toString());

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                        appBar: AppBar(
                          centerTitle: true,
                          title: Text(
                            section.title,
                            style: GoogleFonts.almarai(),
                          ),
                          actions: <Widget>[
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                showSearch(
                                    context: context,
                                    delegate: SectionSearch(section.accounts));
                              },
                            ),
                            /* IconButton(
                              icon: Icon(Icons.list),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            )*/
                          ],
                        ),
                        body:
                            SectionWidget(section, sections.indexOf(section))),
                  ),
                );
              },
              child: Column(
                children: [
                  Flexible(
                    flex: 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.network(
                        section.pic,
                        //fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Container(
                      width: 110,

                      //  padding: EdgeInsets.all(8),

                      child: Text(
                        section.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.almarai(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
