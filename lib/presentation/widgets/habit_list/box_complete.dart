import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/core/utils/date_utilities.dart';

class BoxComplete extends StatelessWidget {
  const BoxComplete({super.key, required this.dates, required this.color});
  final List<int> dates;
  final int color;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
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
                  borderRadius: BorderRadius.circular(20),
                  color: dates.contains(fecha.millisecondsSinceEpoch)
                      ? Color(color)
                      : Color(color).withOpacity(0.5),
                ),
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInCubic,
              );
            })
      ],
    );
  }
}
