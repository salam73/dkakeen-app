import 'package:flutter/material.dart';

class EmergencyNumbersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CustomCard('الشرطة : ٢١١',
            'https://image.freepik.com/free-vector/police-icon-image_24911-43156.jpg'),
        CustomCard('الإطفاء : ٢١١',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTa7vX2arMQNgKiyPRHCSVlGPQAtD-rLAGo-7HONqfgtRypvbbj'),
        CustomCard('الإسعاف : ٢١١ ',
            'https://pngimage.net/wp-content/uploads/2018/05/ambulance-icon-png-3.png'),
      ],
    );
  }
}

Widget _myListView(BuildContext context) {
  final titles = [
    'bike',
    'boat',
    'bus',
    'car',
    'railway',
    'run',
    'subway',
    'transit',
    'walk'
  ];

  final icons = [
    Icons.directions_bike,
    Icons.directions_boat,
    Icons.directions_bus,
    Icons.directions_car,
    Icons.directions_railway,
    Icons.directions_run,
    Icons.directions_subway,
    Icons.directions_transit,
    Icons.directions_walk
  ];

  return ListView.builder(
    itemCount: titles.length,
    itemBuilder: (context, index) {
      return Card(
        //                           <-- Card widget
        child: ListTile(
          leading: Icon(icons[index]),
          title: Text(titles[index]),
        ),
      );
    },
  );
}

class CustomCard extends StatelessWidget {
  final String name;
  // final IconData icons;
  final String url;

  CustomCard(this.name, this.url);

  void whatsAppOpen() {
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: GestureDetector(
        onTap: () => whatsAppOpen(),
        child: Container(
          child: new Stack(
            children: <Widget>[
              Card(
                child: Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  height: 100.0,
                  width: double.infinity,
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              FractionalTranslation(
                translation: Offset(0.0, -0.4),
                child: Align(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(url),
                    backgroundColor: Colors.transparent,
                  ),
                  alignment: FractionalOffset(0.5, 0.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
