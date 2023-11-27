import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{

  final int version=1;
  final String databaseName='friendfindr.db';       //PLURAL
  final String tableName= 'users_favorites';        //PLURAL

  Database? _db;

  //funcion patra la creacion de nuetsra base de datos
  Future<Database> openDb()async{
    //abrir el directorio donde estan las databases y lo uno con el nombre de nuestra base se datos
    _db = await openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (database, version){
          String query= '''CREATE TABLE $tableName (
  id_name TEXT,
  id_value TEXT,
  firstName TEXT,
  lastName TEXT,
  title TEXT,
  email TEXT,
  location TEXT,
  cell TEXT,
  picture TEXT,
  gender TEXT,
  PRIMARY KEY (id_name, id_value)
)''';

          log(query);
          database.execute(query);
        }, version: version
    );
    return _db as Database;
  }
}