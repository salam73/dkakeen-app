import 'package:madayen/model/model.dart';
import 'package:madayen/widgets/account_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  // static ItemsBuilder item = ItemsBuilder();

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> favoriteList = [];

  List<Area> area = ItemsBuilder().buildByArea();

  List<Account> favoriteAccount = [];
  Future<void> _getref() async {
    final pref = await SharedPreferences.getInstance();

    favoriteList = pref.getStringList('favorite');

/*
شغلة مهمه كلش
ترتيب عنصر for
إذا صار اختلاف بترتيب عنصر for راح تصير مشكلة ترتيب الشغلات الثانية
 */
    for (String favorite in favoriteList)
      for (Area area in area)
        for (Account account in area.accounts)
          if (favorite == account.id) {
            print(account.id);
            setState(() {
              favoriteAccount.add(account);
            });
          }
  }

  Future<void> _resetref() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      //  favoriteList = [];
      favoriteAccount = [];
    });
    await pref.setStringList('favorite', []);
  }

  Future<void> _deletefavorite({int index}) async {
    final pref = await SharedPreferences.getInstance();

    favoriteList.removeAt(index);
    setState(() {
      favoriteAccount.removeAt(index);
    });
    await pref.setStringList('favorite', favoriteList);
  }

  @override
  void initState() {
    _getref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('clear all'),
        Expanded(
          child: ListView.builder(
              itemCount: favoriteAccount.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          body: AccountWidget(account: favoriteAccount[index]),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    //height: 280,
                    width: double.infinity,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () => {
                                              print(index),
                                              _deletefavorite(index: index)
                                              //  _deletefavorite(section: _section[index], account: _account[index])
                                              // _resetref()
                                            }
                                        // _resetref(),
                                        ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () => {
                                              _resetref()
                                              //  _deletefavorite(section: _section[index], account: _account[index])
                                              // _resetref()
                                            }
                                        // _resetref(),
                                        ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text(
                                      favoriteAccount[index].title,
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
                                    favoriteAccount[index].pics[0],
                                    height:
                                        100, // need to see this line of code again
                                    //fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text(
                                favoriteAccount[index].address,
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                favoriteAccount[index].hours,
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
                );
              }),
        ),
      ],
    );
  }
}
