import 'package:madayen/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  final Account account;

  const MyMap({Key key, this.account}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  List<Marker> allMarkers = [];

  GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId(widget.account.title),
        draggable: false,
        infoWindow: InfoWindow(
            title: widget.account.title, snippet: widget.account.address),
        position: widget.account.latLng));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });

    if (widget.account.title != null)
      _controller.showMarkerInfoWindow(MarkerId(widget.account.title));
  }

  @override
  Widget build(BuildContext context) {
    // _controller.showMarkerInfoWindow(MarkerId('myMarker'));
    // _controller.showMarkerInfoWindow(MarkerId(widget.account.title));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.account.title),
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(target: widget.account.latLng, zoom: 16.0),
            markers: Set.from(allMarkers),
            onMapCreated: mapCreated,
          ),
        ),
      ]),
    );
  }
}
