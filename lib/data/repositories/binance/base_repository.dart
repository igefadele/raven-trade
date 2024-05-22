import 'package:raventrade/data/models/models.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class BaseRepository {
  Future<List<SymbolResponseModel>> fetchSymbols();

  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String interval,
    int? endTime,
  });

  WebSocketChannel establishSocketConnection({
    required String symbol,
    required String interval,
  });
}
