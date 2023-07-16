

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLangToAddressUpgradedPackage extends StatefulWidget {
  const ConvertLatLangToAddressUpgradedPackage({Key? key}) : super(key: key);

  @override
  State<ConvertLatLangToAddressUpgradedPackage> createState() =>
      _ConvertLatLangToAddressUpgradedPackageState();
}

class _ConvertLatLangToAddressUpgradedPackageState extends State<ConvertLatLangToAddressUpgradedPackage> {
  String stAddress = '', stAdd='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map Upgraded Package'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),
          GestureDetector(
            onTap: () async {


              List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
                   // final coordinates = new Coordinates(33.6992, 72.9744);

              setState(() {
                stAddress=locations.last.longitude.toString()+" "+locations.last.longitude.toString();
              stAdd=placemarks.reversed.last.country.toString()+" "+placemarks.reversed.last.locality.toString();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                ),
                child: Center(
                  child: Text('Convert'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
