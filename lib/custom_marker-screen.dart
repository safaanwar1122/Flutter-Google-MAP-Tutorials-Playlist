import 'dart:async';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({Key? key}) : super(key: key);

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Uint8List? markerImage;

  List<String> images = [
    'assets/car.png',
    'assets/car-wash.png',
    'assets/food-delivery.png',
    'assets/fuel-pump.png',
    'assets/house.png',
    'assets/mall.png'
  ];
  final List<Marker> _markers = <Marker>[
    Marker(
      markerId: MarkerId('12'),
      position: LatLng(33.6941, 72.9734),
    )
  ];
  final List<LatLng> _latLang = <LatLng>[
    LatLng(33.6941, 72.9734),
    LatLng(33.700, 72.9682),
    LatLng(33.6992, 72.9744),
    LatLng(33.610, 72.9807),
    LatLng(33.7036, 72.9785),
    LatLng(33.6939, 72.9771),
  ];
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6910, 72.98072),
    zoom: 15,
  );
  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _latLang[i],
        icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: InfoWindow(
          title: 'This is title marker: ' + i.toString(),
        ),
      ));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
