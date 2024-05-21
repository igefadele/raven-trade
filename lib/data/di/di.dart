import 'package:get/get.dart';

class DependencyProvider {
  static bool isRegistered<T extends Object>(
      {Object? instance, String? instanceName}) {
    return Get.isRegistered<T>(tag: instanceName);
  }

  static T get<T extends Object>({String? instanceName}) {
    return Get.find<T>(tag: instanceName);
  }

  static registerSingleton<T extends Object>(T instance,
      {String? instanceName, bool permanent = false}) {
    Get.put(instance, tag: instanceName, permanent: permanent);
  }

  static registerLazySingleton<T extends Object>(T Function() factory,
      {String? instanceName, bool permanent = false}) {
    Get.lazyPut(factory, tag: instanceName, fenix: permanent);
  }

  static registerFactory<T extends Object>(T Function() factory,
      {String? instanceName, bool permanent = false}) {
    Get.lazyPut(factory, tag: instanceName, fenix: permanent);
  }

  static T checkAndGet<T extends Object>(T Function() factory,
      {String? instanceName}) {
    if (isRegistered<T>(instanceName: instanceName)) {
      return Get.find<T>(tag: instanceName);
    } else {
      Get.put(factory.call(), tag: instanceName);
      return Get.find<T>(tag: instanceName);
    }
  }
}
