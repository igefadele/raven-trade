import 'package:get/get.dart';
import 'package:raventrade/data/providers/base/base_provider.dart';
import 'package:raventrade/data/repositories/base/base_repository.dart';
import 'package:raventrade/data/services/network_config/network_service.dart';

mixin GlobalController {
  BaseProvider get binanceProvider => Get.find();
  BaseRepository get binanceRepository => Get.find();
  NetworkService get networkClient => Get.find();
}
