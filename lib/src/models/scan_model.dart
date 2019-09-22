import 'package:flutter/foundation.dart';
import 'package:latlong/latlong.dart';

class ScanModel{

  int id;
  String tipo;
  String valor;

  ScanModel( { this.id, this.tipo, @required this.valor }){

    if( this.valor.contains( 'http' ) ){
      this.tipo = 'http';
    }
    else{
      this.tipo = 'geo';
    }
  }

  factory ScanModel.fromJson( Map<String, dynamic> json ){
    return new ScanModel(
      id    : json['id'],
      tipo  : json['tipo'],
      valor : json['valor']
    );
  }

  Map<String, dynamic> toJson() => {
    "id"    : id,
    "tipo"  : tipo,
    "valor" : valor
  };

  LatLng getLatLng(){
    print( valor );
    print( valor.substring(4) );
    final latlng = valor.substring( 4 ).split( ',' );
    final lat = double.parse( latlng[ 0 ] );
    final lng = double.parse( latlng[ 1 ] );

    return LatLng( lat, lng );
  }

}