import 'package:madayen/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account_widget.dart';

class SectionWidget extends StatefulWidget {
  final Section section;

  SectionWidget(this.section);

  @override
  _SectionWidgetState createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  List<String> favoriteAccountId = [];

  Future<void> getShared() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      if (pref.getStringList('favorite') !=
          null) if (pref.getStringList('favorite').length != 0) {
        favoriteAccountId = pref.getStringList('favorite');
      }
    });
  }

  Future<void> _setref({String accountId}) async {
    final pref = await SharedPreferences.getInstance();

    if (!favoriteAccountId.contains(accountId))
      setState(() {
        favoriteAccountId.insert(0, accountId);
      });
    else {
      int index = favoriteAccountId
          .indexWhere((element) => element.contains(accountId));
      setState(() {
        favoriteAccountId.removeAt(index);
      });
    }

    await pref.setStringList('favorite', favoriteAccountId);
  }

  @override
  void initState() {
    getShared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.section.accounts
          // .where((element) => element.title.contains('مطاعم'))
          //.where((element) => element.address.contains(''))
          .map((account) => Container(
                //height: 280,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    widget.section.accounts.indexOf(account).toString();
                    print('accountIndex:' +
                        widget.section.accounts.indexOf(account).toString());
                    //  print('sectionIndex:' + _sectionIndex.toString());

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AccountWidget(account: account)),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  IconButton(
                                    icon: getmyfavorite(
                                      areaId: account.id,
                                    )
                                        ? Icon(
                                            Icons.star,
                                            color: Colors.red,
                                          )
                                        : Icon(
                                            Icons.star_border,
                                            color: Colors.grey,
                                          ),
                                    onPressed: () {
                                      _setref(
                                        accountId: widget
                                            .section
                                            .accounts[widget.section.accounts
                                                .indexOf(account)]
                                            .id,
                                      );
                                    },
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.share,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () => {
                                            // _resetref(),
                                            share(context, account),
                                          }),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    account.title,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12.0),
                                ),
                                child: account.logo != null
                                    ? Image.network(
                                        account.logo,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit
                                            .fill, // need to see this line of code again
                                        //fit: BoxFit.fill,
                                      )
                                    : Image.network(account.pics[0],
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill
                                        // need to see this line of code again
                                        //fit: BoxFit.fill,
                                        ),
                              ),
                            ],
                          ),
                          /* Divider(
                            color: Colors.blueGrey,
                          ),*/
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              account.address,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              account.hours,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  bool getmyfavorite({String areaId}) {
    if (favoriteAccountId.contains(areaId))
      return true;
    else
      return false;
  }
}

share(BuildContext context, Account account) {
  final RenderBox box = context.findRenderObject();
  if (account.latLng != null)
    Share.share(
        "${account.title} - ${account.description}"
        "\n${account.address}"
        "\nhttps://maps.google.com/?q=${account.latLng.latitude},${account.latLng.longitude}",
        subject: account.title,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  else
    Share.share(
        "${account.title} - ${account.description}"
        "\n${account.address}",
        subject: account.title,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}
