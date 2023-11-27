
import 'package:friend_findr/database/AppDatabase.dart';
import 'package:sqflite/sqflite.dart';

import '../models/User.dart';

class UserRepository{

  //insertar un user
  Future insert(User user) async{
    Database db= await AppDatabase().openDb();

    db.insert(AppDatabase().tableName, user.toMap());
  }

  Future delete(User user) async{
    Database db= await AppDatabase().openDb();

    db.delete(AppDatabase().tableName,
        where: "id=?", whereArgs:[user.id]);
  }

  //lista users que se marcaron como favorito
  Future<bool> isAdd(User user) async{
    Database db= await AppDatabase().openDb();

    final maps=await db.query(AppDatabase().tableName,
        where: "id=?", whereArgs: [user.id]);

    //maps esta lleno es true, por eso el "isNotEmpty"
    return maps.isNotEmpty;  //devuelve todos los que se guardaron en la tabla
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
          Location(maps[i]['city']),
          maps[i]['email'],
          maps[i]['cell'],
          maps[i]['id'],
          Picture(maps[i]['picture']));
    });
  }

}