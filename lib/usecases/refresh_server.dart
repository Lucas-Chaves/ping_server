import 'dart:async';

import 'package:clean_server/entities/Server.dart';
import 'package:clean_server/repository/repository.dart';
import 'package:clean_server/usecases/get_ping.dart';
import 'package:flutter/cupertino.dart';

abstract class RefreshServer {
  refreshServerTimer(List<Server> servers);

  refreshServerPull(List<Server> servers);
}

class RefreshServerImpl implements RefreshServer {
  final timeout = const Duration(minutes: 10);
  Timer _timer;

  Repository repo;

  RefreshServerImpl(this.repo) {
    _startTimeout();
  }

  @override
  refreshServerPull(List<Server> servers) {
    _timer.cancel();
    _startTimeout();
  }

  @override
  refreshServerTimer(List<Server> servers) async {
    for (int i = 0; i < servers.length; i++) {
      await Future.delayed(Duration(seconds: 5))
          .then((_) async => await pingAndSave(servers[i]));
    }
    _startTimeout();
  }

  _startTimeout() {
    this._timer = Timer(timeout, _handleTimeout);
  }

  void _handleTimeout() {
    _startTimeout();
  }

  pingAndSave(itemServer) async {
    final ping = await GetPingImpl(repo).pingServer(itemServer);
    itemServer.online = ping;
    await repo.updateServer(itemServer);
  }
}
