import 'package:raventrade/data/models/response_models/symbol_response_model.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:raventrade/data/repositories/base/base_repository.dart';
import 'package:raventrade/ui/global/global_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BaseRepositoryImpl with GlobalController implements BaseRepository {
  @override
  WebSocketChannel establishSocketConnection({
    required String symbol,
    required String interval,
  }) {
    return binanceProvider.establishSocketConnection(
      symbol: symbol,
      interval: interval,
    );
  }

  @override
  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String interval,
    int? endTime,
  }) async {
    return binanceProvider.fetchCandles(
      symbol: symbol,
      interval: interval,
    );
  }

  @override
  Future<List<SymbolResponseModel>> fetchSymbols() async {
    return binanceProvider.fetchSymbols();
  }
}
