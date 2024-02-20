import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/core/utils/color_utils.dart';
import 'package:minimal_habit_tracker/core/utils/date_utilities.dart';

class BoxComplete extends StatelessWidget {
  const BoxComplete({super.key, required this.dates, required this.color});
  final List<int> dates;
  final int color;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 35),
            itemCount: DateUtilities.daysOfTheMonth(),
            itemBuilder: (context, index) {
              DateTime fecha =
                  DateUtilities.firstDayOfTheMonth().add(Duration(days: index));

              return AnimatedContainer(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      dates.contains(fecha.millisecondsSinceEpoch)
                          ? ColorUtils.adjustLightness(Color(color))
                          : Color(color).withOpacity(0.5),
                      dates.contains(fecha.millisecondsSinceEpoch)
                          ? Color(color)
                          : Color(color).withOpacity(0.5)
                    ],
                    stops: const [0.1, 1.0],
                    center: Alignment.topLeft,
                    radius: 1.0,
                  ),
                ),
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInCubic,
              );
            })
      ],
    );
  }
}
