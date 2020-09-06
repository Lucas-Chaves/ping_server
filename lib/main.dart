import 'package:clean_server/constantes.dart';
import 'package:clean_server/entities/Server.dart';
import 'package:clean_server/repository/repository.dart';
import 'package:clean_server/usecases/refresh_server.dart';
import 'package:clean_server/usecases/servers/create_server.dart';
import 'package:clean_server/usecases/servers/get_all_server.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "servidor1.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE ${Constantes.serverTable}(${Constantes.idColumn} INTEGER PRIMARY KEY, ${Constantes.urlColumn} TEXT, ${Constantes.boolColumn} INTEGER)");
    });
  }

  Database _db = await initDB();
  runApp(MainApp(_db));
}

class MainApp extends StatefulWidget {
  final Database database;

  const MainApp(this.database);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final repository = Repository(widget.database);

    return Container();
  }
}

