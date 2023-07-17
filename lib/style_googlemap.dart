import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMap extends StatefulWidget {
  const StyleGoogleMap({Key? key}) : super(key: key);

  @override
  State<StyleGoogleMap> createState() => _StyleGoogleMapState();
}

class _StyleGoogleMapState extends State<StyleGoogleMap> {
  String mapTheme = '';
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6910, 72.98072),
    zoom: 15,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('asset/maptheme/night_theme.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Theme'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('asset/maptheme/night_theme.json')
                        .then((string) {
                      value.setMapStyle(string);
                    });
                  });
                },
                child: Text('Night'),
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('asset/maptheme/silver_theme.json')
                        .then((string) {
                      value.setMapStyle(string);
                    });
                  });
                },
                child: Text('Silver'),
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('asset/maptheme/retro_theme.json')
                        .then((string) {
                      value.setMapStyle(string);
                    });
                  });
                },
                child: Text('Retro'),
              ),

            ],
          ),
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(mapTheme);
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
