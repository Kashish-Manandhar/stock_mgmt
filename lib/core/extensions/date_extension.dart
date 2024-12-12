 extension XDateTime on DateTime {
  DateTime  get todayStartTime => copyWith(hour: 0, minute: 0, second: 0);

  DateTime get nextDayStartTime =>
      copyWith(day: day + 1, hour: 0, minute: 0, second: 0);

  List<DateTime> get getFirstAndLastDayOfWeek {
    final firstDay = subtract(Duration(days: weekday == 7 ? 0 : weekday));

    final lastDay = firstDay.add(const Duration(days: 7));
    return [firstDay, lastDay];
  }

  List<DateTime> get getFirstAndLastDayOfMonth {
    return [
      copyWith(day: 1),
      copyWith(
          year: month == 12 ? year + 1 : year,
          month: month == 12 ? 1 : month + 1,
          day: 1)
    ];
  }
}
