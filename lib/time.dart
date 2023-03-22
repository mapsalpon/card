import 'package:intl/intl.dart';
import 'package:taro/language_translate.dart';

class MonthTime {
  late final int monthNumber;
  late final int firstWeekDay;
  late final int amountOfDays;

  String get monthAsWord {
    var monthWord = DateFormat.MMMM().format(DateTime(2001, monthNumber));

    monthWord = Language().monthEngToRus(monthWord);

    return monthWord;
  }

  int? get year {
    return DateTime(DateTime.now().year, monthNumber).year;
  }

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