import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/views/directions_view.dart';
import 'package:qrreaderapp/src/views/home_view.dart';
import 'package:qrreaderapp/src/views/map_launch_view.dart';
import 'package:qrreaderapp/src/views/maps_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build( BuildContext context ){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home'      : ( BuildContext context ) => HomeView(),
        'map'       : ( BuildContext context ) => MapsView(),
        'direction' : ( BuildContext context ) => DirectionsView(),
        'map_launch': ( BuildContext context ) => MapLaunchView()
      },
      theme: ThemeData(
        primaryColor: Colors.orange
      ),
    );
  }
}