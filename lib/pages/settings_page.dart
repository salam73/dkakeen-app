import 'dart:async';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool mysalam = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
            child: MaterialButton(
          onPressed: () {
            FlutterOpenWhatsapp.sendSingleMessage("4531223388", "Hello");
          },
          child: Text('خدمة الزابئن'),
        )),
        FlatButton(
          onPressed: () => changeBrightness(context),
          child: Theme.of(context).brightness != Brightness.dark
              ? Text('الوضع المظلم')
              : Text('الوضع العادي'),
        ),
      ],
    );
  }

  changeBrightness(BuildContext context) {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
}

changeColor(BuildContext context) {
  DynamicTheme.of(context).setThemeData(new ThemeData(
      primaryColor: Theme.of(context).primaryColor == Colors.indigo
          ? Colors.red
          : Colors.indigo));
}

showChooser(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return BrightnessSwitcherDialog(
        onSelectedTheme: (Brightness brightness) {
          DynamicTheme.of(context).setBrightness(brightness);
        },
      );
    },
  );
}
