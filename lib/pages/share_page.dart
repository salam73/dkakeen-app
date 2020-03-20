import 'package:flutter/material.dart';
import 'package:madayen/main.dart';
import 'package:madayen/model/model.dart';

class SharePage extends StatelessWidget {
  final Account account;

  SharePage({this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('account.title'),
    );
  }
}
