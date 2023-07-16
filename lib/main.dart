import 'package:flutter/material.dart';

import 'convert_latlang_to_address.dart';
import 'convert_latlang_to_address_upgraded_package.dart';
import 'get_user_current_location.dart';
import 'home-screen.dart';

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
      home: const GetUserCurrentLocationScreen(),
    );
  }
}
