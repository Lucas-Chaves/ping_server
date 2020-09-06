import 'package:clean_server/entities/Server.dart';
import 'package:clean_server/repository/repository.dart';

abstract class CreateServer {
  createServer(Server server);
}

class CreateServerImpl implements CreateServer {
  final Repository _repo;

  CreateServerImpl(this._repo);

  @override
  createServer(Server server) async {
    await _repo.saveServer(server);
  }
}
