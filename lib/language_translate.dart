class Language {
  final Map<String, String> _monthEngToRus = {
    'January' : 'Январь',
    'February' : 'Февраль',
    'March' : 'Март',
    'April' : 'Апрель',
    'May' : 'Май',
    'June' : 'Июнь',
    'July' : 'Июль',
    'August' : 'Август',
    'September' : 'Сентябрь',
    'October' : 'Октябрь',
    'November' : 'Ноябрь',
    'December' : 'Декабрь',
  };


  ///Если значение некорректно, вёрнется пустая строка
  String monthEngToRus(String input) {
    return _monthEngToRus[input] ?? '1';
}
}