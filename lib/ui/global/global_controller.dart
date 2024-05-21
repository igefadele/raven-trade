import 'package:get/get.dart';
import 'package:raventrade/data/providers/binance/binance_provider.dart';
import 'package:raventrade/data/repositories/binance/binance_repository.dart';
import 'package:raventrade/data/services/network_config/network_client.dart';

mixin GlobalController {
  BinanceProvider get binanceProvider => Get.find();
  BinanceRepository get binanceRepository => Get.find();
  NetworkClient get networkClient => Get.find();
}
