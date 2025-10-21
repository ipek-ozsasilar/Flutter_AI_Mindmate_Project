import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/gen/assets.gen.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/appbars/message_appbar.dart';
import 'package:flutter_mindmate_project/products/bottom_appbars/message_bottom_appbar.dart';
import 'package:flutter_mindmate_project/products/constants/paddings.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/widgets/texts/general_text_widget.dart';

part 'sub_view/mood_chart_widget.dart';
part 'sub_view/mood_legend_widget.dart';
part 'sub_view/date_range_button.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  bool isSevenDays = true;
  final CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;
  final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.scaffoldBackgroundColor,
      appBar: MessageAppbar(title: StringsEnum.proggres.value),
      body: SingleChildScrollView(
        child: Padding(
          padding: Paddings.paddingInstance.generalHorizontalPadding,
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Padding(
                padding: Paddings.paddingInstance.progressViewTitleTopPadding,
                child: GeneralTextWidget(
                  text: StringsEnum.progressTitle.value,
                  color: ColorName.whiteColor,
                  size: TextSizesEnum.todayCardTitleSize.value,
                ),
              ),

              Padding(
                padding: Paddings
                    .paddingInstance
                    .profileImagePickerTopAndBottomPadding,
                child: GeneralTextWidget(
                  text: StringsEnum.progressSubtitle.value,
                  color: ColorName.loginGreyTextColor,
                  size: TextSizesEnum.subtitleSize.value,
                ),
              ),

              // Tarih Aralığı Seçici
              Row(
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  Padding(
                    padding: Paddings
                        .paddingInstance
                        .progressViewDateRangeButtonPadding,
                    child: _DateRangeButton(
                      text: StringsEnum.lastSevenDays.value,
                      isSelected: isSevenDays,
                      onTap: () => setState(() => isSevenDays = true),
                    ),
                  ),

                  _DateRangeButton(
                    text: StringsEnum.lastThirtyDays.value,
                    isSelected: !isSevenDays,
                    onTap: () => setState(() => isSevenDays = false),
                  ),
                ],
              ),

              // Grafik
              Padding(
                padding: Paddings.paddingInstance.splashImageVerticalPadding,
                child: _MoodChartWidget(isSevenDays: isSevenDays),
              ),

              // Legend (Renkli Açıklamalar)
              Padding(
                padding: Paddings.paddingInstance.emptyHistoryWidgetPadding,
                child: const _MoodLegendWidget(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MessageBottomAppbar(),
    );
  }
}
