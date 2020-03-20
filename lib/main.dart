import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madayen/pages/fcm.dart';
import 'package:madayen/pages/map_page.dart';
import 'package:madayen/pages/neighborhoods.dart';
import 'package:madayen/pages/share_page.dart';
import 'model/model.dart';

import 'pages/advertisements_page.dart';
import 'pages/competitions_page.dart';
import 'pages/emergency_numbers_page.dart';
import 'pages/favorites_page.dart';

import 'pages/home_page.dart';
import 'pages/jobs_page.dart';

import 'pages/news_page.dart';
import 'pages/personal_info_page.dart';
import 'pages/promotions_page.dart';
import 'pages/settings_page.dart';
import 'dart:async';
import 'package:giffy_dialog/giffy_dialog.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'widgets/account_widget.dart';

import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primarySwatch: Colors.indigo,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Section> sections = ItemsBuilder().build();
  List<Account> accounts = [];

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription;
  //Widget selectedPage = HomePageWidget();
  int _currentIndex = 0;
  // final List<Widget> _children = [];

  AppSection selectedPage = appSections[0];

  void onTabTapped(int index) {
    setState(() {
      if (index == 0)
        selectedPage = appSections[index];
      else
        selectedPage = appSections[index + 11];

      _currentIndex = index;
    });
  }

  @override
  void initState() {
    fcm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // automaticallyImplyLeading: false,
        title: Text(
          selectedPage.title,
          style: GoogleFonts.almarai(),
          textDirection: TextDirection.rtl,
        ),
        /*leading: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Scaffold(
                      appBar: AppBar(
                        title: Text('المفضلة'),
                      ),
                  body: FavoritesPage(),
                ),
              ),
            );
          },
        ),*/
      ),
      body: selectedPage.widget,

      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ArabicText('كربلاء', Colors.white),
                  ArabicText('username', Colors.white),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
            ),
            ...appSections
                .where((element) => !element.title.contains('الأحياء'))
                .map(
                  (page) => ListTile(
                    trailing: Icon(
                      page.icon,
                      color: Colors.deepPurple,
                    ),
                    title: Text(
                      page.title,
                      textDirection: TextDirection.rtl,
                    ),
                    onTap: () {
                      setState(() {
                        //weh
                        if (page.title.contains('الصفحة الرئيسية'))
                          _currentIndex = 0;

                        selectedPage = page;
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
          ],
        ),
      ),
      // add bottom tap to main page
      //bottom tap shows only in 2 pages الرئيسية والأحياء

      bottomNavigationBar: selectedPage.title.contains('الصفحة الرئيسية') ||
              selectedPage.title.contains('الأحياء')
          ? BottomNavigationBar(
              onTap: onTabTapped, // new
              currentIndex: _currentIndex, // new
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.subject),
                  title: Text('الأقسام'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map),
                  title: Text('الأحياء'),
                ),
              ],
            )
          : null,
    );
  }

  fcm() {
    for (Section section in sections)
      for (Account account in section.accounts) accounts.add(account);

    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print(data);
        _saveDeviceToken();
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        showDialog(
            context: context,
            builder: (_) => NetworkGiffyDialog(
                  image: Image.network(message['data']['accountpic']),
                  title: Text(message['notification']['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600)),
                  description: Text(
                    message['notification']['body'],
                    textAlign: TextAlign.center,
                  ),
                  onlyOkButton: true,
                  buttonOkText: Text(
                    'شاهد',
                    style: TextStyle(color: Colors.white),
                  ),
                  onOkButtonPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => /*SharePage()*/
                            AccountWidget(
                          account: accounts.firstWhere(
                            (element) => element.id
                                .contains(message['data']['accountname']),
                          ),
                        ),
                      ),
                    );
                  },
                ));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountWidget(
              account: accounts.firstWhere(
                (element) =>
                    element.id.contains(message['data']['accountname']),
              ),
            ),
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountWidget(
              account: accounts.firstWhere(
                (element) =>
                    element.id.contains(message['data']['accountname']),
              ),
            ),
          ),
        );
      },
    );
  }

  _saveDeviceToken() async {
    // Get the current user
    String uid = 'jeffd23';
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .document(uid)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }

  /// Subscribe the user to a topic
  _subscribeToTopic() async {
    // Subscribe the user to a topic
    _fcm.subscribeToTopic('puppies');
  }
}

class ArabicText extends StatelessWidget {
  final String text;
  final Color _color;

  const ArabicText(this.text, this._color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: TextStyle(fontSize: 24, color: _color),
    );
  }
}

class AppSection {
  final Widget widget;
  final IconData icon;
  final String title;

  AppSection(this.widget, this.icon, this.title);
}

List<AppSection> appSections = [
  AppSection(HomePage(), Icons.home, 'الصفحة الرئيسية'),
  AppSection(MyGoogleMap(), Icons.map, 'الخريطة'),
  AppSection(PersonalInfoPage(), Icons.person, 'المعلومات الشخصية'),
  AppSection(FavoritesPage(), Icons.favorite, 'المفضلة'),
  AppSection(PromotionsPage(), Icons.monetization_on, 'العروض و التخفيضات'),
  AppSection(AdvertisementsPage(), Icons.ac_unit, 'الإعلانات'),
  AppSection(JobsPage(), Icons.build, 'المهن و الحرف'),
  AppSection(CompetitionsPage(), Icons.category, 'المسابقات'),
  AppSection(NewsPage(), Icons.fiber_new, 'الأخبار'),
  AppSection(EmergencyNumbersPage(), Icons.directions_car, 'أرقام الطوارئ'),
  AppSection(SettingsPage(), Icons.settings, 'إعدادات التطبيق'),
  AppSection(
      SharePage(
        account: null,
      ),
      Icons.share,
      'شارك التطبيق'),
  AppSection(Neighborhoods(), Icons.share, 'الأحياء'),
  //AppSection(SectionWidget(sections:null), Icons.share, 'الأحياء'),
];
