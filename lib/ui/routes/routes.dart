import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:raventrade/ui/modules/home/bindings/home_binding.dart';
import 'package:raventrade/ui/modules/home/views/home_view.dart';

class Routes {
  Routes._();
  static const home = '/home';

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
