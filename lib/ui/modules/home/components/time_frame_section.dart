import 'package:get/get.dart' hide ContextExtensionss;
import 'package:raventrade/constants/app_assets.dart';
import 'package:raventrade/core/values/colors/app_colors.dart';
import 'package:raventrade/core/values/strings/text_constants.dart';
import 'package:raventrade/ui/global/extensions/context_extension.dart';
import 'package:raventrade/ui/modules/home/controllers/home_controller.dart';
import 'package:raventrade/ui/global/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimeFrameSection extends StatefulWidget {
  final Function(String) onSelected;

  const TimeFrameSection({
    required this.onSelected,
    super.key,
  });

  @override
  State<TimeFrameSection> createState() => _TimeFrameSectionState();
}

class _TimeFrameSectionState extends State<TimeFrameSection> {
  final List<String> timeframes = [
    '1H',
    '2H',
    '4H',
    '1D',
    '1W',
    '1M',
  ];

  final controller = Get.find<HomeController>();
  String interval = "1H";

  @override
  void initState() {
    super.initState();
    interval = controller.currentInterval.value;
    controller.reInitialize(controller.currentInterval.value);
  }

  setInterval(String value) {
    setState(() {
      controller.currentInterval.value = value;
      interval = value;
      controller.reInitialize(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            AppText.body1(
              TIME,
              color:
                  context.isDarkMode ? AppColors.white : AppColors.blackTint2,
            ),
            Gap.w4,
            ...timeframes.map(
              (e) => InkWell(
                onTap: () {
                  widget.onSelected.call(e);
                  setInterval(e);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 40,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    //color: controller.currentInterval.value == e
                    color: interval == e
                        ? context.isDarkMode
                            ? const Color(0xff555C63)
                            : const Color(0xffCFD3D8)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: AppText.body1(
                      e,
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.blackTint2,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 25,
                    color: AppColors.divider.withOpacity(.08),
                  ),
                  const Gap(5),
                  SvgPicture.asset(
                    AppAssets.charts,
                  )
                ],
              ),
            ),
            Gap.w6,
            Container(
              width: 1,
              height: 25,
              color: AppColors.divider.withOpacity(.08),
            ),
            Gap.w6,
            AppText.body1(
              'Fx Indicators',
              color: context.isDarkMode
                  ? AppColors.blackTint
                  : AppColors.blackTint2,
            ),
            Gap.w6,
          ],
        ),
      ),
    );
  }
}
