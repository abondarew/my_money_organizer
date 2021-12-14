import 'package:mymoneyorganizer/app/core/common/const/period.dart';

Map<String, DateTime> getTypicalPeriod(ReportingPeriodType periodType) {
  Map<String, DateTime> result = {};
  DateTime currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  switch (periodType) {
    case ReportingPeriodType.day:
      {
        result["startDate"] = currentDate;
        result["endDate"] = currentDate;
        return result;
      }
    case ReportingPeriodType.week:
      {
        result["startDate"] =
            DateTime(currentDate.year, currentDate.month, currentDate.day).subtract(Duration(days: currentDate.weekday - 1));
        result["endDate"] = currentDate;
        return result;
      }
    case ReportingPeriodType.month:
      {
        result["startDate"] = DateTime(currentDate.year, currentDate.month, 1);
        result["endDate"] = currentDate;
        return result;
      }
    case ReportingPeriodType.year:
      {
        result["startDate"] = DateTime(currentDate.year, 1, 1);
        result["endDate"] = currentDate;
        return result;
      }
    case ReportingPeriodType.seven_days:
      {
        result["startDate"] = DateTime(currentDate.year, currentDate.month, currentDate.day).subtract(Duration(days: 7));
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
