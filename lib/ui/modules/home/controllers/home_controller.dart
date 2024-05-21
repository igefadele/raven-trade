import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raventrade/core/utils/app_logger.dart';
import 'package:raventrade/core/values/strings/constants.dart';
import 'package:raventrade/data/enums/base_enums.dart';
import 'package:raventrade/data/models/errors/errors.dart';
import 'package:raventrade/data/models/models.dart';
import 'package:raventrade/ui/global/global_controller.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController with GlobalController {
  final _logger = appLogger(HomeController);

// VARIABLES
  RxInt selectedInterval = 0.obs;
  RxList<SymbolResponseModel> symbols = <SymbolResponseModel>[].obs;
  WebSocketChannel? channel;

  RxList<Candle> candles = <Candle>[].obs;
  RxString currentInterval = "1H".obs;
  Rx<SymbolResponseModel> currentSymbol =
      SymbolResponseModel(symbol: 'BTCUSDT', price: '').obs;
  RxInt currentTabIndex = 0.obs;
  RxInt bottomTabIndex = 0.obs;
  Rx<ModuleState> moduleState = (ModuleState.idle).obs;
  Rx<Failure> moduleError =
      ModuleFailure(failureMessage: '', failureTitle: '').obs;

  Rxn<CandleTickerModel> candleTicker = Rxn<CandleTickerModel>();
  Rxn<OrderBook> orderBooks = Rxn<OrderBook>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  RxBool candleLoading = false.obs;
  RxBool symbolLoading = false.obs;
  RxBool websocketLoading = false.obs;
  RxBool reInitializing = false.obs;

  @override
  onInit() {
    _logger.d('==== \n\nHOME CONTROLLER CALLED!\n\n ====');
    init();
    super.onInit();
  }

  // ENTRY POINT
  // Get the symbols, then get the candles and if they are not available,
  //then initialize websocket and get needed data
  void init() {
    getSymbols();
    getCandles(currentSymbol.value, currentInterval.value).then((value) {
      if (candleTicker.value == null) {
        initializeWebSocket(
          interval: currentInterval.value,
          symbol: currentSymbol.value.symbol,
        );
      }
    });
  }

  // GET SYMBOLS
  Future<void> getSymbols() async {
    _logger.d("Getting Symbols.....");
    symbolLoading.value = true;
    try {
      moduleState.value = ModuleState.busy;
      final result = await binanceRepository.getSymbols();
      symbols.value = result;
      _logger.d("Symbols Length ===> ${symbols.length}");
      if (symbols.isNotEmpty) {
        debugPrint('\n\result symbol: ${result[11].toJson()} \n\n\n');
        currentSymbol.value = symbols[11];
      }
      moduleState.value = ModuleState.idle;
    } on Failure catch (e) {
      moduleState.value = ModuleState.error;
      moduleError.value = e;
      _logger.e(e.message);
    } catch (e) {
      _logger.e(e.toString());
      final err =
          AppError("unknown error", "an error occurred, please try again.");
      moduleState.value = ModuleState.error;
      moduleError.value = err;
    }
    symbolLoading.value = false;
  }

  // GET THE CANDLES
  Future<List<Candle>> getCandles(
      SymbolResponseModel symbol, String interval) async {
    _logger.d("Getting Candles......");
    candleLoading.value = true;
    try {
      moduleState.value = ModuleState.busy;
      final result = await binanceRepository.getCandles(
        symbol: symbol.symbol,
        interval: interval.toLowerCase(),
      );
      candles.value = result;
      _logger.d("Candles Length :: ${candles.length}");
      moduleState.value = ModuleState.idle;
      candleLoading.value = false;
      return result;
    } on Failure catch (e) {
      moduleState.value = ModuleState.error;
      moduleError.value = e;
      _logger.e(e.message);
      candleLoading.value = false;
      return candles;
    } catch (e) {
      _logger.e(e.toString());
      final err =
          AppError("unknown error", "an error occurred, please try again.");
      moduleState.value = ModuleState.error;
      moduleError.value = err;
      candleLoading.value = false;
      return candles;
    }
  }

  // INITIALIZE THE WEBSOCKET
  Future<void> initializeWebSocket({
    required String symbol,
    required String interval,
  }) async {
    _logger.d("Initializing websocket..");
    websocketLoading.value = true;

    final chn = binanceRepository.establishSocketConnection(
      interval: interval.toLowerCase(),
      symbol: symbol.toLowerCase(),
    );

    await for (final String value in chn.stream) {
      final map = jsonDecode(value) as Map<String, dynamic>;
      final eventType = map['e'];

      if (eventType == KLINE) {
        final candleTickerInfo = CandleTickerModel.fromJson(map);
        candleTicker.value = candleTickerInfo;
        if (candles.isNotEmpty &&
            candles[0].date == candleTicker.value!.candle.date &&
            candles[0].open == candleTickerInfo.candle.open) {
          candles[0] = candleTickerInfo.candle;
        } else if (candles.isNotEmpty &&
            candleTicker.value!.candle.date.difference(candles[0].date) ==
                candles[0].date.difference(candles[1].date)) {
          candles.insert(0, candleTicker.value!.candle);
        }
      } else if (eventType == DEPTH_UPDATE) {
        final orderBookInfo = OrderBook.fromMap(map);
        orderBooks.value = orderBookInfo;
      }
    }
    websocketLoading.value = false;
  }

  // TO LOAD MORE CANDLES
  Future<void> loadMoreCandles(StreamValueDTO streamValue) async {
    try {
      final data = await binanceRepository.getCandles(
        symbol: streamValue.symbol.symbol,
        interval: streamValue.interval!,
        endTime: candles.last.date.millisecondsSinceEpoch,
      );
      candles
        ..removeLast()
        ..addAll(data);
    } on Failure catch (e) {
      _logger.d("Custom Error fetching candles ==> ${e.message}");
    } catch (e) {
      _logger.d("Error fetching more candles ::: ${e.toString()}");
    }
  }

  // RE_INITIALIZE FROM HOMEPAGE
  Future<void> reInitialize(String value) async {
    debugPrint('CALLED REFRESH');
    reInitializing.value = true;
    currentInterval.value = value;
    if (currentSymbol.value.symbol != '') {
      getCandles(currentSymbol.value, currentInterval.value).then((value) {
        if (candleTicker.value == null) {
          initializeWebSocket(
            interval: currentInterval.value,
            symbol: currentSymbol.value.symbol,
          );
        }
      });
    }
    reInitializing.value = false;
  }
}
