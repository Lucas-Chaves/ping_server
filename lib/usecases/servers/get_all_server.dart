import 'package:clean_server/entities/Server.dart';
import 'package:clean_server/repository/repository.dart';

abstract class GetAllServer {
  getAllServer();
}

class GetAllServerImpl implements GetAllServer {
  final Repository _repo;

  GetAllServerImpl(this._repo);

  @override
  getAllServer() async {
    List<Server> listServers =  await _repo.getAllServer();
    return listServers;
  }
}
