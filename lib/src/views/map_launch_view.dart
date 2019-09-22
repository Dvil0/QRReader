import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapLaunchView extends StatelessWidget{

  @override
  Widget build( BuildContext context ){

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text( 'Coordinates QR' ),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.my_location ),
            onPressed: (){},
          ),
        ],
      ),
      body: _createFlutterMap( scan ),
    );
  }

  Widget _createFlutterMap( ScanModel scan ){

    
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10,
      ),
      layers: [
        _createMap(),
      ],
    );
  }

  TileLayerOptions _createMap(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
        '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : 'pk.eyJ1IjoiZGFudmlsIiwiYSI6ImNrMHVhenFwYzBqYTEzbG1kODQxeGJsZnYifQ.Y26p10W7yvttf5hUaQ5LCQ',
        'id'          : 'mapbox.streets',
      }
    );
  }
}