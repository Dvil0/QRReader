import 'package:flutter/foundation.dart';

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

}