import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'Columns.dart';
import 'ColumnsBase.dart';
import 'Tables.dart';

class DatabaseHandler {

  static Database? _database;
  static final DatabaseHandler db = DatabaseHandler._();
  static const String DATABASE_NAME = "amidb";


  DatabaseHandler._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
        
        
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        final path = join(documentsDirectory.path, DATABASE_NAME);


        try {

              
              return await openDatabase(path, version: 1, onOpen: (db) {},
              onCreate: (Database db, int version) async {

              

              });



        } catch (e) {
          
        }

  }


}