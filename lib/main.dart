import 'package:flutter/material.dart';
import 'package:google_map_playlist/polygon_screen.dart';
import 'package:google_map_playlist/polyline.dart';
import 'package:google_map_playlist/style_googlemap.dart';

import 'convert_latlang_to_address.dart';
import 'convert_latlang_to_address_upgraded_package.dart';
import 'custom_marker-screen.dart';
import 'custom_marker_info_window.dart';
import 'get_user_current_location.dart';
import 'google_places_api.dart';
import 'home-screen.dart';
import 'network_image_marker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StyleGoogleMap(),
    );
  }
}
