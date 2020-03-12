import 'package:madayen/model/model.dart';
import 'package:madayen/widgets/account_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NeighborhoodPage extends StatefulWidget {
  final Area area;

  NeighborhoodPage({this.area});

  @override
  _NeighborhoodPageState createState() => _NeighborhoodPageState();
}

class _NeighborhoodPageState extends State<NeighborhoodPage> {
  List<Area> area = ItemsBuilder().buildByArea();

  List<String> favoriteAccountId = [];

  Future<void> getShared() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      if (pref.getStringList('favorite') != null ||
          pref.getStringList('favorite').length != 0) {
        favoriteAccountId = pref.getStringList('favorite');
      }
    });

    print(favoriteAccountId);
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
    // print(salam[0].title);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.area.name),
        ),
        body: ListView(
          children: widget.area.accounts
              // .where((element) => element.title.contains('مطاعم'))
              //.where((element) => element.address.contains(''))
              .map((account) => Container(
                    height: 180,
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        //height: 280,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            widget.area.accounts.indexOf(account).toString();
                            print('accountIndex:' +
                                widget.area.accounts
                                    .indexOf(account)
                                    .toString());
                            //  print('sectionIndex:' + _sectionIndex.toString());

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AccountWidget(account: account)),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.grey,
                                                  ),
                                            onPressed: () {
                                              _setref(
                                                accountId: widget
                                                    .area
                                                    .accounts[widget
                                                        .area.accounts
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
                                        child: Image.network(
                                          account.pics[0],
                                          height:
                                              100, // need to see this line of code again
                                          //fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 0),
                                      child: Text(
                                        account.address,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        account.hours,
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'favorite',
                          color: Colors.blue,
                          icon: Icons.star,
                          onTap: () => {
                            //print('archive')
                          },
                        ),
                        IconSlideAction(
                          caption: 'Share',
                          color: Colors.indigo,
                          icon: Icons.share,
                          onTap: () => share(context, account),
                        ),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'More',
                          color: Colors.black45,
                          icon: Icons.more_horiz,
                          onTap: () => {},
                        ),
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () => {},
                        ),
                      ],
                    ),
                  ))
              .toList(),
        )

        /*ListView(
        children: widget.area.accounts
            .map(
              (account) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountWidget(account: account)),
                  );
                },
                child: Card(
                  elevation: 4,
                  child: Container(
                    height: 150,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                IconButton(
                                  icon: getmyfavorite(
                                    areaId: account.id,
                                  )
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          color: Colors.grey,
                                        ),
                                  onPressed: () {
                                    _setref(accountId: account.id);
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
                            Text(account.title),
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.0),
                              ),
                              child: Image.network(
                                account.pics[0],
                                height:
                                    100, // need to see this line of code again
                                //fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        Text(account.address),
                        Text(account.hours),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),*/
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
