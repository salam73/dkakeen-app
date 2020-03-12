import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //todo need
    return Column(
      children: <Widget>[
        Center(
            child: MaterialButton(
          onPressed: () {
            FlutterOpenWhatsapp.sendSingleMessage("4531223388", "Hello");
          },
          child: Text('خدمة الزابئن'),
        )),
      ],
    );
  }
}
