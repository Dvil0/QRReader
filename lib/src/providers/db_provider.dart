import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
export 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider{

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async{

    if( _database != null ) return _database;

    _database = await initDB();

    return _database;
  }

  Future initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join( documentsDirectory.path, 'ScansDB.db' );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: ( Database db, int version ) async{
        await db.execute(
          'CREATE TABLE Scans('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')'
        );
      }
    );
  }

  //CREAR registros
  nuevoScanRaw( ScanModel nuevoScan ) async{
    
    final db = await database;

    final resp = await db.rawInsert(
      "INSERT INTO Scans (id, tipo, valor) "
      "VALUES ( ${ nuevoScan.id }, '${ nuevoScan.tipo }', '${ nuevoScan.valor }' )"
    );

    return resp;
  }

  nuevoScan( ScanModel nuevoScan ) async{

    final db = await database;

    final resp = await db.insert( 'Scans', nuevoScan.toJson() );

    return resp;
  }

  //SELECT registros.

  Future<ScanModel> getScanById( int id )async{

    final db = await database;

    final resp = await db.query('Scans', where: 'id=?', whereArgs: [id]);

    return resp.isNotEmpty ? ScanModel.fromJson( resp.first ) : null;
  }

  Future<List<ScanModel>> getAllScans() async{
    final db = await database;

    final resp = await db.query('Scans');

    List<ScanModel> list = resp.isNotEmpty 
                              ? resp.map( (scan) => ScanModel.fromJson(scan) ).toList()
                              : [];

    return list;
  }

  Future<List<ScanModel>> getScansByTipo( String tipo ) async{
    final db = await database;

    final resp = await db.rawQuery(
      "SELECT * FROM Scans WHERE tipo='$tipo'"
    );

    List<ScanModel> list = resp.isNotEmpty 
                              ? resp.map( (scan) => ScanModel.fromJson(scan) ).toList()
                              : [];

    return list;
  }

  //UPDATE registros.
  Future<int> updateScanById( ScanModel nuevoScan ) async{
    final db = await database;
    final resp = await db.update('Scans', nuevoScan.toJson(), where: 'id=?', whereArgs: [nuevoScan.id] );
    return resp;
  }

  //DELETE registros.
  Future<int> deleteScanById( int id )async{
    final db = await database;
    final resp = await db.delete('Scans',where: 'id=?', whereArgs:[ id ]);
    return resp;
  }

  Future<int> deleteAllScan()async{
    final db = await database;
    final resp = await db.rawDelete('DELETE FROM Scans');
    return resp;
  }

}