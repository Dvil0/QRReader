import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc{
  
  static final ScansBloc _singleton = new ScansBloc._internal();
  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){

    //Get Scans from data base.
    getScans();

  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose(){
    _scansController?.close();
  }

  getScans() async{

    _scansController.sink.add( await DBProvider.db.getAllScans() );

  }

  addScan( ScanModel scan ) async{
    await DBProvider.db.nuevoScan( scan );
    getScans();
  }

  deleteScanById( int id ) async{

    await DBProvider.db.deleteScanById( id );
    getScans();

  }

  deleteScans()async{
    await DBProvider.db.deleteAllScan();
    getScans();
  }
}