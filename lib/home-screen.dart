import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  // GoogleMap has controller that locate changing position when camera is moved
  //for  controller completer is used, and is passed on googleMap in onMapCreated
  Completer<GoogleMapController> _controller=Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        //initialCameraPosition is used for main screen of google map that appears on screnn when map is opened
        // it give you overall view of map
        //when you are moving postition at map screen basically camera is changing its position
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationEnabled: true,
        compassEnabled: false,
        //mapType: MapType.hybrid,
        //mapType: MapType.satellite, // it will give satellite view
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
