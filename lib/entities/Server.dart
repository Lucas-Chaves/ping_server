import 'package:clean_server/constantes.dart';

class Server {
  int id;
  String url;
  bool online;

  Server({this.id, this.url, this.online});


  Map toMap() {
    Map<String, dynamic> map = {
      Constantes.urlColumn: url,
      Constantes.boolColumn: online  ? 1 : 0,
    };
    return map;
  }

  Server.fromMap(Map map) {
    id = map[Constantes.idColumn];
    url = map[Constantes.urlColumn];
    online = map[Constantes.boolColumn] == 1 ? true : false;
  }



}
