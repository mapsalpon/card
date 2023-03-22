class MonthTime {
  int? monthNumber;
  int? firstWeekDay;
  int? amountOfDays;

  MonthTime.now() {
    var timeNow = DateTime.now();
    monthNumber = timeNow.month;
    firstWeekDay = DateTime(timeNow.year, timeNow.month, 1).weekday;
    amountOfDays = DateTime(timeNow.year, timeNow.month + 1, 0).day;
  }

  MonthTime.fromMonthNumber({int? year, required int month}) {
    year ??= DateTime.now().year;
    monthNumber = month;
    firstWeekDay = DateTime(year, month, 1).weekday;
    amountOfDays = DateTime(year, month + 1, 0).day;
  }

  @override
  String toString() {
    return '${[
      monthNumber,
      firstWeekDay,
      amountOfDays,
    ]}';
  }
}