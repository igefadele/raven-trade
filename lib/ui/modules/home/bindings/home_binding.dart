import 'package:get/get.dart';
import 'package:raventrade/data/di/di.dart';
import 'package:raventrade/ui/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerLazySingleton<HomeController>(
        () => HomeController());
  }
}
