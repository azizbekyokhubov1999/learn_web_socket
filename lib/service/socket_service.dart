import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class SocketService{
  static final _uri = Uri.parse("wss://ws-feed.exchange.coinbase.com");
  static final _channel = WebSocketChannel.connect(_uri);
  static final stream = _channel.stream.asBroadcastStream();
  static final sink = _channel.sink;
  static const Map<String, dynamic> message = <String, dynamic>{
    "type": "subscribe",
    "product_ids": [
      "ETH-USD",
      "ETH-EUR"
    ],
    "channels": [
      "ticker"
    ]
  };
  static bool isLoading = false;

  static Future<void> init()async{
    isLoading = false;
    await _channel.ready;
    _channel.sink.add(jsonEncode(message));
    isLoading = true;
  }
}