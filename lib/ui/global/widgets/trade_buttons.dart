// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raventrade/core/values/colors/app_colors.dart';
import 'package:raventrade/core/values/strings/constants.dart';
import 'widgets.dart';

enum TradeType {
  Buy,
  Sell,
}

extension TradeTypeExtension on TradeType {
  bool get isSell => this == TradeType.Sell;
  bool get isBuy => this == TradeType.Buy;
}

class TradeButton extends StatelessWidget {
  final TradeType type;
  final void Function()? onPressed;
  const TradeButton({
    Key? key,
    required this.type,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 171.spMin,
      height: 32,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: type.isBuy ? AppColors.green : AppColors.red,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        onPressed: onPressed,
        child: AppText.button(
          type.isBuy ? BUY : SELL,
          color: Colors.white,
        ),
      ),
    );
  }
}
