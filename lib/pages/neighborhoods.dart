import 'package:madayen/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'neighborhood_page.dart';

class Neighborhoods extends StatelessWidget {
  List<Area> areas = ItemsBuilder().buildByArea();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        //  reverse: true,

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemCount: areas.length,
        //shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NeighborhoodPage(
                          area: areas[index],
                        )),
              );
            },
            child: Card(
              //                           <-- Card widget

              child: Center(
                child: Text(
                  areas[index].name,
                  style: GoogleFonts.almarai(),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
