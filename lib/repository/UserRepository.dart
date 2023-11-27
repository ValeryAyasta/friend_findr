
import 'package:friend_findr/database/AppDatabase.dart';
import 'package:sqflite/sqflite.dart';

import '../models/User.dart';

class UserRepository{

  //insertar un user
  Future insert(User user) async{
    Database db= await AppDatabase().openDb();

    db.insert(AppDatabase().tableName, user.toMap()).then((value) => print('Agregado'));

    //print('Agregado');
  }

  Future delete(User user) async {
    Database db = await AppDatabase().openDb();

    db.delete(
      AppDatabase().tableName,
      where: "id_name = ? AND id_value = ?",
      whereArgs: [user.id!.name, user.id!.value],
    ).then((value) => print('Eliminado'));
  }


  Future<bool> isAdd(User user) async {
    Database db = await AppDatabase().openDb();

    final maps = await db.query(
      AppDatabase().tableName,
      where: "id_name = ? AND id_value = ?",
      whereArgs: [user.id!.name, user.id!.value],
    );

    return maps.isNotEmpty;
  }


  Future<List<User>> getAll() async{

    Database db= await AppDatabase().openDb();

    //crea una lista de mapeos, que es el registro de la base de datos de la tabla señalada
    final List<Map<String,dynamic>> maps=await db.query('users_favorites');

    //crea una lista, en donde cada index recorrido y asigno datos a un constructo de la clase "Anime"
    return List.generate(maps.length, (i) {

      return User(
          maps[i]['gender'],
          Name(maps[i]['title'], maps[i]['firstName'], maps[i]['lastName']),
          Location(maps[i]['location']),
          maps[i]['email'],
          maps[i]['cell'],
          Id(maps[i]['id_name'], maps[i]['id_value']),
          Picture(maps[i]['picture']));

    });
  }

}