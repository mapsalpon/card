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
}