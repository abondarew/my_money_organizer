import 'package:mymoneyorganizer/app/core/common/constant/monetary_movement.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/report_model/contract/dashboard_widget_model_contract.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/category_model.dart';
import 'package:mymoneyorganizer/app/core/dashboard_widgets/dashboard_widget_contact.dart';
import 'package:mymoneyorganizer/app/core/common/constant/report_period.dart';

class ExpensesByCategoryModel implements DashboardWidgetContract{

}

/*
/// @startDate дата начала отчета
/// @endDate   дата окончания отчета.
/// Формируются, исходя из переданного типа отчетного периода [ReportingPeriodType]
*/
class ExpensesByCategorySettingModel implements DashboardWidgetSettingModelContract{
  DateTime startDate;
  DateTime endDate;
  List<CategoryReadModel> includingCategory;
  List<MonetaryMovementType> includingMonetaryMovement;
  List<MonetaryMovementType> excludingMonetaryMovement;
}