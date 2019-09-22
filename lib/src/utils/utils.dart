import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL( BuildContext context, ScanModel scan ) async{
  
  if( scan.tipo == 'http' ){

    if( await canLaunch( scan.valor )){
      return await launch( scan.valor );
    } else {
      throw 'No se puede lanzar ${ scan.valor }';
    }

  }else { 
    Navigator.pushNamed( context, 'map_launch', arguments: scan );
  }
} 