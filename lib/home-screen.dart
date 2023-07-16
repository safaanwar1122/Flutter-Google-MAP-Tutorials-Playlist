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
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(33.5921, 72.9962), zoom: 14.4746);
  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(33.5921, 72.9962),
      infoWindow: InfoWindow(title: 'My  location '),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(33.5651, 73.0169),
      infoWindow: InfoWindow(title: 'My current location '),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(33.6844, 73.0479),
      infoWindow: InfoWindow(title: 'My current location '),
    ),
    Marker(
      markerId: MarkerId('4'),
      position: LatLng(35.6762, 139.6503),
      infoWindow: InfoWindow(title: 'Tokyo Japan '),
    ),
  ];
  //37.42796133580664, -122.085749655962
  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          //initialCameraPosition is used for main screen of google map that appears on screnn when map is opened
          // it give you overall view of map
          //when you are moving postition at map screen basically camera is changing its position
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: false,
          //mapType: MapType.hybrid,
          //mapType: MapType.satellite, // it will give satellite view
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: () async{
          GoogleMapController controller=await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(35.6762, 139.6503),
              zoom: 14,
              )));
          setState(() {

          });
        },
      ),
    );
  }
}
