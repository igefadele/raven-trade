import 'package:get/get.dart';
import 'package:raventrade/data/di/di.dart';
import 'package:raventrade/data/providers/binance/base_provider.dart';
import 'package:raventrade/data/providers/binance/base_provider_impl.dart';
import 'package:raventrade/data/repositories/binance/base_repository.dart';
import 'package:raventrade/data/repositories/binance/base_repository_impl.dart';
import 'package:raventrade/data/services/network_config/network_service.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerSingleton<BaseProvider>(
      BaseProviderImpl(),
      permanent: true,
    );

    DependencyProvider.registerSingleton<BaseRepository>(
      BaseRepositoryImpl(),
      permanent: true,
    );

    DependencyProvider.registerSingleton<NetworkService>(
      NetworkService(),
      permanent: true,
    );
  }
}
