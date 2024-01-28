import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/core/utils/functions/date_utilities.dart';

class BoxComplete extends StatelessWidget {
  const BoxComplete({super.key, required this.dates});
  final List<int> dates;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 20),
            itemCount: 365,
            itemBuilder: (context, index) {
              DateTime fecha =
                  DateUtilities.firstDayOfTheYear().add(Duration(days: index));

              if (dates.contains(fecha.millisecondsSinceEpoch)) {
                return Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.greenAccent,
                  ),
                );
              } else {
                return Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.greenAccent.withOpacity(0.5),
                  ),
                );
              }
            })
      ],
    );
  }
}
