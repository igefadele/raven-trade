import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;

  // function to switch between themes
  void switchTheme() {
    currentTheme.value = (currentTheme.value == ThemeMode.light)
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
