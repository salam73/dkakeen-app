import 'package:madayen/model/model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountLyout extends StatefulWidget {
  final Account account;

  AccountLyout(this.account);

  @override
  _AccountLyoutState createState() => _AccountLyoutState();
}

class _AccountLyoutState extends State<AccountLyout> {
  List<String> favoriteAccountId = [];

  Future<void> getShared() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      if (pref.getStringList('favorite') != null ||
          pref.getStringList('favorite').length != 0) {
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
    return Container();
  }
}
