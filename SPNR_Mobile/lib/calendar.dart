import 'package:flutter/material.dart'; // syncfusion's calendar was a much better package, however it will infringe
import 'package:table_calendar/table_calendar.dart'; // copyright for our customer

class BuildCalendar extends StatelessWidget {
  const BuildCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      monthViewSettings: MonthViewSettings(showAgenda: true),
    );
  }
}