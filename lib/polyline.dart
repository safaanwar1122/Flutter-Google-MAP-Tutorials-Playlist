import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineScreen extends StatefulWidget {
  const PolyLineScreen({Key? key}) : super(key: key);

  @override
  State<PolyLineScreen> createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.738045, 73.084488),
    zoom: 14,
  );
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [
    //array
    LatLng(33.738045, 73.084488),
    LatLng(33.6992, 72.9744),
    LatLng(33.610, 72.9807),

    LatLng(33.567997728, 72.635997456)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i=0;i<latlng.length;i++){
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: latlng[i],

        infoWindow: InfoWindow(
          title: 'Cool Place: ',
          snippet: '5 Star Rating',
        ),  icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polyline.add(Polyline(polylineId: PolylineId('1'),
        points: latlng,
        color: Colors.orange,
      ));
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PolyLine'),
      ),
      body: GoogleMap(
        markers: _markers,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        polylines: _polyline,
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
      ),
    );
  }
}
