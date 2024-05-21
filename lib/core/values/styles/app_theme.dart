import 'package:raventrade/core/values/colors/app_colors.dart';
import 'package:raventrade/core/values/strings/constants.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  AppThemeData._();

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: SATOSHI,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: AppColors.black,
      scaffoldBackgroundColor: const Color(0xffF8F8F9),
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
      cardColor: AppColors.white,
      shadowColor: const Color(0xffF1F1F1),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: AppColors.blackTint2,
        labelColor: AppColors.rockBlack,
      ),
      textTheme: const TextTheme().apply(
        bodyColor: AppColors.black,
        displayColor: AppColors.black,
      ),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: SATOSHI,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: AppColors.white,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
      cardColor: AppColors.primaryBlack,
      shadowColor: AppColors.cardStroke,
      scaffoldBackgroundColor: AppColors.rockBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryBlack,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.rockBlack,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: AppColors.white,
        labelColor: AppColors.white,
      ),
      textTheme: const TextTheme().apply(
        fontFamily: SATOSHI,
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    );
  }
}
