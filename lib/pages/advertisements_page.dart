import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madayen/model/model.dart';
import 'package:madayen/services/addfirebase.dart';

import 'package:geoflutterfire/geoflutterfire.dart';

class AdvertisementsPage extends StatefulWidget {
  @override
  _AdvertisementsPageState createState() => _AdvertisementsPageState();
}

class _AdvertisementsPageState extends State<AdvertisementsPage> {
  final Firestore _db = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  List<Section> sections = ItemsBuilder().build();

  AddFirebase addFirebase;

  saveDeviceToken(Account account) async {
    // Get the current user
    String uid = 'noor';
    GeoFirePoint point;
    // FirebaseUser user = await _auth.currentUser();

    String fcmToken = 'dfgdsfgds';
    if (account.latLng != null)
      point = geo.point(
          latitude: account.latLng.latitude,
          longitude: account.latLng.longitude);
    //point.hash = 'hello';

    // Save it to Firestore
    if (account.title != null) {
      var tokens = _db
          .collection('salam')
          .document(uid)
          .collection('accounts')
          .document(account.title);

      await tokens.setData({
        'title': account.title,
        'address': account.address,
        'areaName': account.areaName,
        'description': account.description,
        'latLng': point.geoPoint,

        // optional
      });
    }
  }

  getData() {
    for (Section section in sections)
      for (Account account in section.accounts) {
        saveDeviceToken(account);
      }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: FlatButton(
          color: Colors.grey,
          onPressed: getData,
          child: Text('getdata'),
        ),
      ),
    );
  }
}
