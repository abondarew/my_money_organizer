enum ReportingPeriodType {
  day,            //текущий день
  week,           //текущая неделя
  last_week,      //прошлая неделя
  seven_days,     //последние 7 дней
  month,          //текущий месяц
  last_month,     //прошлый месяц
  quarter,        //3 месяца (квартал)
  year,           //текущий год
  specified,      //явно указанный
  all             //весь период
}

Map<String, DateTime> getTypicalPeriod(ReportingPeriodType periodType) {
  Map<String, DateTime> result = new Map();
  DateTime currentDate = new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  switch (periodType) {
    case ReportingPeriodType.day:
      {
        result["startDate"] = currentDate;
        result["endDate"] = currentDate;
        return result;
      }
    case ReportingPeriodType.week:
      {
        result["startDate"] = new DateTime(currentDate.year, currentDate.month, currentDate.day)
            .subtract(Duration(days: currentDate.weekday - 1));
        result["endDate"] = currentDate;
        return result;
      }
    case ReportingPeriodType.month:
      {
        result["startDate"] = new DateTime(currentDate.year, currentDate.month, 1);
        result["endDate"] = currentDate;
        return result;
      }
    case ReportingPeriodType.year:
      {
        result["startDate"] = new DateTime(currentDate.year, 1, 1);
        result["endDate"] = currentDate;
        return result;
      }
    case ReportingPeriodType.seven_days:
      {
        result["startDate"] =
            new DateTime(currentDate.year, currentDate.month, currentDate.day).subtract(Duration(days: 7));
        result["endDate"] = currentDate;
        return result;
      }
    case ReportingPeriodType.quarter:
      // TODO: Handle this case.
      break;
    case ReportingPeriodType.specified:
      // TODO: Handle this case.
      break;
    case ReportingPeriodType.all:
      // TODO: Handle this case.
      break;
    case ReportingPeriodType.last_week:
      // TODO: Handle this case.
      break;
    case ReportingPeriodType.last_month:
      // TODO: Handle this case.
      break;
  }
  return result;
}
