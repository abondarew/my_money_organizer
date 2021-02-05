import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/constant/monetary_movement.dart';
import 'package:mymoneyorganizer/app/core/common/constant/report_period.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/report_model/contract/dashboard_widget_model_contract.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/category_model.dart';
import 'package:mymoneyorganizer/app/core/dashboard_widgets/dashboard_widget_contact.dart';

class ExpensesByCategoryModel implements DashboardWidgetContract {
  final CategoryReadModel category;
  final double totalAmount;

  ExpensesByCategoryModel({@required this.category, @required this.totalAmount});
}

/*
/// @startDate дата начала отчета
/// @endDate   дата окончания отчета.
/// Формируются, исходя из переданного типа отчетного периода [ReportingPeriodType]
*/
class ExpensesByCategorySettingModel implements DashboardWidgetSettingModelContract {
  DateTime startDate;
  DateTime endDate;
  List<CategoryReadModel> includingCategory;
  List<MonetaryMovementType> includingMonetaryMovement;
  List<MonetaryMovementType> excludingMonetaryMovement;

  ExpensesByCategorySettingModel(
      {@required ReportingPeriodType periodType,
      this.includingCategory,
      this.includingMonetaryMovement,
      this.excludingMonetaryMovement}) {
    DateTime currentDate = new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    switch (periodType) {
      case ReportingPeriodType.day:
        {
          startDate = endDate = currentDate;
        }
        break;
      case ReportingPeriodType.week:
        {
          startDate = new DateTime(currentDate.year, currentDate.month, currentDate.day);
          startDate = (startDate.subtract(Duration(days: startDate.weekday - 1)));
          endDate = currentDate;
        }
        break;
      case ReportingPeriodType.month:
        {
          startDate = new DateTime(currentDate.year, currentDate.month, 1);
          endDate = currentDate;
        }
        break;
      case ReportingPeriodType.year:
        {
          startDate = new DateTime(currentDate.year, 1, 1);
          endDate = currentDate;
        }
        break;
      case ReportingPeriodType.seven_days:
        {
          startDate = new DateTime(currentDate.year, currentDate.month, currentDate.day);
          startDate = startDate.subtract(Duration(days: 7));
          endDate = currentDate;
        }
    }
  }
}
