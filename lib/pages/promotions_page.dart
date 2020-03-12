import 'package:flutter/material.dart';

class PromotionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Column(

        children: <Widget>[
          Card(
            elevation: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(

                      alignment: Alignment.center,
                      child: Text('salam')),
                ),
                Image.network('https://picsum.photos/100/100?random'),
              ],
            ),
          ), Card(
            elevation: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(

                      alignment: Alignment.center,
                      child: Text('salam')),
                ),
                Image.network('https://picsum.photos/100/100?random'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

