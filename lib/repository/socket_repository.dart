import 'package:flutter_docs/clients/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepoitoty {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;
}
