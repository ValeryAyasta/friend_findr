import 'dart:convert';
import 'dart:io';                               //importar .io
import 'package:http/http.dart' as http;

import '../models/User.dart';

class UserService{

  //https://api.jikan.moe/v4/top/anime?page=2
  String baseUrl="https://randomuser.me/api/";
  final String _results = '?results=';

  //devuelve en algun momento una lista
  Future<List<User>?> getAll(int result) async{
    //concatena un dato a la ruta
    http.Response response=await http.get(Uri.parse('$baseUrl$_results$result'));

    //si la respuesta devuelve algo
    if(response.statusCode==HttpStatus.ok){

      //es la respuesta de tod el json
      final jsonResponse=json.decode(response.body);
      //crea una lista llamada maps que recoge tod del json
      final List maps=jsonResponse["results"];
      //cada map es asignado a un objeto usando su metodo de fromJson
      final data = maps.map<User>((e) => User.fromJson(e)).toList();
      print(data);
      return data;

    }
    print(response.body);                   //MENSAJITO SOBRE QUE DEVOLVIO LA LLAMADA
    return null;
  }
}