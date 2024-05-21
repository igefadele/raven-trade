import 'dart:convert';

import 'package:raventrade/core/utils/app_logger.dart';
import 'package:raventrade/data/models/models.dart';
import 'package:raventrade/data/providers/binance/binance_provider.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:raventrade/ui/global/global_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceProviderImpl with GlobalController implements BinanceProvider {
  final _logger = appLogger(BinanceProviderImpl);
  @override
  WebSocketChannel establishSocketConnection(
      {required String symbol, required String interval}) {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws'),
    );

    channel.sink.add(
      jsonEncode(
        {
          'method': 'SUBSCRIBE',
          'params': ['$symbol@kline_$interval'],
          'id': 1
        },
      ),
    );

    channel.sink.add(
      jsonEncode(
        {
          'method': 'SUBSCRIBE',
          'params': ['$symbol@depth'],
          'id': 1
        },
      ),
    );

    return channel;
  }

  @override
  Future<List<Candle>> getCandles(
      {required String symbol, required String interval, int? endTime}) async {
    final String uri =
        "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval${endTime != null ? "&endTime=$endTime" : ""}";
    final data = await networkClient.get(uri) as List;
    _logger.d("Candles... $data");
    return data.map((e) => Candle.fromJson(e)).toList().reversed.toList();
  }

  @override
  Future<List<SymbolResponseModel>> getSymbols() async {
    const uri = "https://api.binance.com/api/v3/ticker/price";
    final res = await networkClient.get(uri) as List;
    _logger.d("Symbols Response:: $res");
    final arr = res.map((e) => SymbolResponseModel.fromMap(e)).toList();

    return arr;
  }
}
