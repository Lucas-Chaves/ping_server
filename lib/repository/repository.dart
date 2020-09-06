import 'package:clean_server/constantes.dart';
import 'package:clean_server/entities/Server.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  final _dio = Dio();
  final Database _db;

  Repository(this._db);

  Future<Response> ping(String url) async {
    final response = await _dio.get(url);
    return response;
  }



  Future<bool> saveServer(Server server) async {
    await _db.insert(Constantes.serverTable, server.toMap());
    return true;
  }

  Future<Server> get(int id) async {
    List<Map> maps = await _db.query(Constantes.serverTable,
        columns: [Constantes.idColumn,Constantes.urlColumn,Constantes.boolColumn],
        where: "${Constantes.idColumn} = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Server.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteServer(int id) async {
    return await _db
        .delete(Constantes.serverTable, where: "${Constantes.idColumn} = ?", whereArgs: [id]);
  }

  Future<int> updateServer(Server server) async {
    return await _db.update(Constantes.serverTable, server.toMap(),
        where: "${Constantes.idColumn} = ?", whereArgs: [server.id]);
  }

  Future<List<Server>> getAllServer() async {
    List listMap = await _db.rawQuery("SELECT * FROM ${Constantes.serverTable}");
    List<Server> listServer = List();
    for (Map m in listMap) {
      listServer.add(Server.fromMap(m));
    }
    return listServer;
  }

  Future close() async {
    await _db.close();
  }
}
