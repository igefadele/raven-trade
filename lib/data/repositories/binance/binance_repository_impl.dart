import 'package:raventrade/data/models/response_models/symbol_response_model.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:raventrade/data/repositories/binance/binance_repository.dart';
import 'package:raventrade/ui/global/global_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceRepositoryImpl with GlobalController implements BinanceRepository {
  @override
  WebSocketChannel establishSocketConnection(
      {required String symbol, required String interval}) {
    return binanceProvider.establishSocketConnection(
        symbol: symbol, interval: interval);
  }

  @override
  Future<List<Candle>> getCandles(
      {required String symbol, required String interval, int? endTime}) async {
    return binanceProvider.getCandles(symbol: symbol, interval: interval);
  }

  @override
  Future<List<SymbolResponseModel>> getSymbols() async {
    return binanceProvider.getSymbols();
  }
}
