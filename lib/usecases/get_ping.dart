import 'package:clean_server/entities/Server.dart';
import 'package:clean_server/repository/repository.dart';

abstract class GetPing {
  pingServer(Server server);
}

class GetPingImpl implements GetPing {
  final Repository _repo;

  GetPingImpl(this._repo);

  @override
  pingServer(Server server) async {
    final response = await _repo.ping(server.url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
