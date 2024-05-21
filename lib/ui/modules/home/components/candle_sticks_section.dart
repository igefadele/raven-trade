import 'package:get/get.dart';
import 'package:raventrade/constants/app_assets.dart';
import 'package:raventrade/core/values/colors/app_colors.dart';
import 'package:raventrade/data/models/models.dart';
import 'package:raventrade/ui/global/extensions/extensions.dart';
import 'package:raventrade/ui/modules/home/components/time_frame_section.dart';
import 'package:raventrade/ui/modules/home/controllers/home_controller.dart';
import 'package:raventrade/ui/global/widgets/widgets.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CandleSticksSection extends StatefulWidget {
  const CandleSticksSection({super.key});
  @override
  State<CandleSticksSection> createState() => _CandleSticksSectionState();
}

class _CandleSticksSectionState extends State<CandleSticksSection> {
  final controller = Get.find<HomeController>();
  CandleTickerModel? get candleTicker => controller.candleTicker.value;
  SymbolResponseModel get currentSymbol => controller.currentSymbol.value;
  String get currentInterval => controller.currentInterval.value;
  List<Candle> get candles => controller.candles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(7),
        TimeFrameSection(
          onSelected: (value) {
            controller.reInitialize(value);
          },
        ),
        const Gap(15),
        Divider(
          color: AppColors.blackTint.withOpacity(.1),
          thickness: 1,
        ),
        Divider(
          color: AppColors.blackTint.withOpacity(.1),
          thickness: 1,
        ),
        if (candles.isNotEmpty)
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Candlesticks(
              key: Key(currentSymbol.symbol + currentInterval),
              candles: candles,
              onLoadMoreCandles: () {
                return controller.loadMoreCandles(
                  StreamValueDTO(
                    symbol: currentSymbol,
                    interval: currentInterval.toLowerCase(),
                  ),
                );
              },
              // displayZoomActions: false,
              actions: [
                ToolBarAction(
                  // width: 40,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SvgPicture.asset(
                      AppAssets.rounded_arrow_down,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                ToolBarAction(
                  width: 60,
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: AppText.caption(
                      currentSymbol.symbol,
                      fontSize: 11,
                      color: AppColors.blackTint2,
                    ),
                  ),
                ),
                if (candleTicker != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          AppText.body2(
                            'O ',
                            fontSize: 11,
                            color: AppColors.blackTint2,
                          ),
                          AppText.body2(
                            candleTicker?.candle.open.formatValue() ?? "-",
                            fontSize: 11,
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (candleTicker != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          AppText.body2(
                            'H ',
                            fontSize: 11,
                            color: AppColors.blackTint2,
                          ),
                          AppText.body2(
                            candleTicker?.candle.high.formatValue() ?? "-",
                            fontSize: 11,
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (candleTicker != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          AppText.body2(
                            'L ',
                            fontSize: 11,
                            color: AppColors.blackTint2,
                          ),
                          AppText.body2(
                            candleTicker?.candle.low.formatValue() ?? "-",
                            fontSize: 11,
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (candleTicker != null)
                  ToolBarAction(
                    width: 55,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          AppText.body2(
                            'C ',
                            fontSize: 11,
                            color: AppColors.blackTint2,
                          ),
                          AppText.body2(
                            candleTicker?.candle.close.formatValue() ?? "-",
                            fontSize: 11,
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
