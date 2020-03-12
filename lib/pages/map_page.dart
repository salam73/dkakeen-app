import 'package:madayen/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

var sections = ItemsBuilder().build();
var accounts = sections[0].accounts;

class MyGoogleMap extends StatefulWidget {
  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  GoogleMapController _controller;
  List<Marker> allMarkers = [];
  PageController _pageController;

  LatLng init_LatLng;
  int prevPage;
  String _mylocation = 'حي ';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (coffeeShops.length == 0)
      accounts.forEach((f) {
        if (f.latLng != null) {
          if (f.address.contains(_mylocation))
            coffeeShops.add(Coffee(
                shopName: f.title,
                address: f.address,
                description: '',
                thumbNail: f.pics[0],
                locationCoords: LatLng(f.latLng.latitude, f.latLng.longitude)));
        }
      });

    setState(() {
      init_LatLng = coffeeShops[0].locationCoords;
    });

    coffeeShops.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.shopName),
          draggable: false,
          infoWindow:
              InfoWindow(title: element.shopName, snippet: element.description),
          position: element.locationCoords));
    });
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 16.0,
                    ),
                    height: 155.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: GestureDetector(
                      onTap: () {
                        _controller.showMarkerInfoWindow(
                            MarkerId(coffeeShops[index].shopName));

                        _controller.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target:
                                    coffeeShops[_pageController.page.toInt()]
                                        .locationCoords,
                                zoom: 16.0,
                                bearing: 45.0,
                                tilt: 45.0)));
                      },
                      child: Container(
                          width: 170,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: Row(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                  height: 80.0,
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              coffeeShops[index].thumbNail),
                                          fit: BoxFit.cover))),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          coffeeShops[index].shopName,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        child: Text(
                                          coffeeShops[index].address,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: 170.0,
                                          child: Text(
                                            coffeeShops[index].description,
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            )
                          ])),
                    )))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        //this is the map
        Container(
          height: MediaQuery.of(context).size.height - 50.0,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(target: init_LatLng, zoom: 16.0),
            markers: Set.from(allMarkers),
            onMapCreated: mapCreated,
          ),
        ),

        Positioned(
          bottom: 40.0,
          child: Container(
            height: 150.0,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              reverse: true,
              onPageChanged: _onPageViewChange,
              controller: _pageController,
              itemCount: coffeeShops.length,
              itemBuilder: (BuildContext context, int index) {
                return _coffeeShopList(index);
              },
            ),
          ),
        )
      ],
    ));
  }

  _onPageViewChange(int page) {
    print("Current Page: " + page.toString());
    _controller.showMarkerInfoWindow(MarkerId(coffeeShops[page].shopName));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
    _controller.showMarkerInfoWindow(MarkerId(coffeeShops[0].shopName));
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: coffeeShops[_pageController.page.toInt()].locationCoords,
        zoom: 16.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}

class Coffee {
  String shopName;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;

  Coffee(
      {this.shopName,
      this.address,
      this.description,
      this.thumbNail,
      this.locationCoords});
}

final List<Coffee> coffeeShops = [
  /*Coffee(
      shopName: 'كربلاء المقدسة Coffee Roasters',
      address: 'كربلاء, حسي الحسين',
      description:
      'Coffee bar chain offering house-roasted direct-trade coffee, along with brewing gear & whole beans',
      locationCoords: LatLng(32.610017, 44.015957),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'
  ),
  Coffee(
      shopName: 'أسواق أهل البيت الغذائية',
      address: 'كربلاء, حسي الحسين',
      description:
      'جميل المأكولات الصحية والغذائية',
      locationCoords: LatLng(32.594978, 44.014841),
      thumbNail: 'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'
  ),
*/
];
