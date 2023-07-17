import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageCustomMarker extends StatefulWidget {
  const NetworkImageCustomMarker({Key? key}) : super(key: key);

  @override
  State<NetworkImageCustomMarker> createState() => _NetworkImageCustomMarkerState();
}

class _NetworkImageCustomMarkerState extends State<NetworkImageCustomMarker> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6910, 72.98072),
    zoom: 15,
  );


  final List<Marker> _markers = <Marker>[  ];
   List<LatLng> _latLang = [
    LatLng(33.6941, 72.9734),
    LatLng(33.700, 72.9682),
    LatLng(33.6992, 72.9744),

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  loadData()async{
for(int i=0;i<_latLang.length;i++)
  {
  Uint8List? image=await loadNetworkImage('https://images.pexels.com/photos/341970/pexels-photo-341970.jpeg?auto=compress&cs=tinysrgb&w=600');

   final ui.Codec markerImageCodec= await instantiateImageCodec(image!.buffer.asUint8List(),
   targetHeight: 300,
     targetWidth: 300,
   );
  final ui.FrameInfo frameInfo=await markerImageCodec.getNextFrame();
   final ByteData? byteDate=await frameInfo.image.toByteData(
     format: ui.ImageByteFormat.png
   );
   final Uint8List resizedImageMarker=byteDate!.buffer.asUint8List();

    _markers.add(Marker(markerId: MarkerId(i.toString()),
    position: _latLang[i],
      icon:BitmapDescriptor.fromBytes(resizedImageMarker),


      infoWindow: InfoWindow(
        title: 'Title of marker'+i.toString(),
      )
    ));
    setState(() {

    });
  }
  }
  Future<Uint8List>loadNetworkImage(String path)async{
    final completer=Completer<ImageInfo>();
    var image=NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info,_) =>completer.complete(info)));
    final imageInfo=await completer.future;
    final byteData=await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
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
