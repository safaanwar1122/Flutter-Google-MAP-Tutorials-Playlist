import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLang = <LatLng>[
    LatLng(33.6941, 72.9734),
    LatLng(33.700, 72.9682),
    LatLng(33.6992, 72.9744),
    LatLng(33.6910, 72.9807),
    LatLng(33.7036, 72.9785),
    LatLng(33.6939, 72.9771),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latLang.length; i++) {
      if (i % 2 == 0) {
        _markers.add(
          Marker(
              markerId: MarkerId(i.toString()),
              icon: BitmapDescriptor.defaultMarker,
              position: _latLang[i],
              onTap: () {
                _customInfoWindowController.addInfoWindow!(
                    Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: CircleAvatar(radius: 39, backgroundColor: Colors.blue,),),
                    ),
                    _latLang[i]);
              }),
        );
      } else {
        _markers.add(
          Marker(
              markerId: MarkerId(i.toString()),
              icon: BitmapDescriptor.defaultMarker,
              position: _latLang[i],
              onTap: () {
                _customInfoWindowController.addInfoWindow!(
                    SingleChildScrollView(
                      child: Container(
                        height: 300,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 300,
                              height: 100,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://images.pexels.com/photos/3392982/pexels-photo-3392982.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                  fit: BoxFit.fitWidth,
                                  filterQuality: FilterQuality.high,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _latLang[i]);
              }),
        );
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Info Window Example '),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(33.6941, 72.9734), zoom: 14),
            markers: Set<Marker>.of(_markers),
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 100,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
