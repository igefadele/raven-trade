import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:raventrade/core/utils/app_logger.dart';
import 'package:raventrade/core/values/strings/constants.dart';
import 'package:raventrade/core/values/styles/app_theme.dart';
import 'package:raventrade/ui/global/global_binding.dart';
import 'package:raventrade/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Main {}

void main() async {
  final logger = appLogger(Main);
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await initialize();
      runApp(const ProviderScope(child: RavenTradeApp()));
    },
    (error, stackTrace) => logger.e(
      error.toString(),
      stackTrace: stackTrace,
      functionName: MAIN,
    ),
  );
}

class RavenTradeApp extends StatelessWidget {
  const RavenTradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => GetMaterialApp(
        scrollBehavior: SBehavior(),
        theme: AppThemeData.lightTheme,
        darkTheme: AppThemeData.darkTheme,
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        enableLog: true,
        initialBinding: GlobalBinding(),
        initialRoute: Routes.home,
        getPages: Routes.routes,
      ),
    );
  }
}
