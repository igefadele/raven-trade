import 'package:get/get.dart';
import 'package:raventrade/data/di/di.dart';
import 'package:raventrade/data/providers/binance/binance_provider.dart';
import 'package:raventrade/data/providers/binance/binance_provider_impl.dart';
import 'package:raventrade/data/repositories/binance/binance_repository.dart';
import 'package:raventrade/data/repositories/binance/binance_repository_impl.dart';
import 'package:raventrade/data/services/network_config/network_client.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerSingleton<BinanceProvider>(
      BinanceProviderImpl(),
      permanent: true,
    );

    DependencyProvider.registerSingleton<BinanceRepository>(
      BinanceRepositoryImpl(),
      permanent: true,
    );

    DependencyProvider.registerSingleton<NetworkClient>(
      NetworkClient(),
      permanent: true,
    );
  }
}
