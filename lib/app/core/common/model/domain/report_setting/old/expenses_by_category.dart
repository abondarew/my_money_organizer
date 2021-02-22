/*
import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/report_model/contract/report_model_contract.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/category_model.dart';
import 'package:mymoneyorganizer/app/core/common/util/monetary_movement.dart';
import 'package:mymoneyorganizer/app/core/common/util/report_period.dart';

class ExpensesByCategoryModel implements ReportModelContract {
  final CategoryReadModel category;
  final double totalAmount;

  ExpensesByCategoryModel({@required this.category, @required this.totalAmount});
}

*/
/*
/// @startDate дата начала отчета
/// @endDate   дата окончания отчета.
/// Формируются, исходя из переданного типа отчетного периода [ReportingPeriodType]
*//*

class ExpensesByCategorySettingModel implements ReportSettingModelContract {
  final DateTime startDate;
  final DateTime endDate;
  final List<CategoryReadModel> includingCategory;
  final List<MonetaryMovementType> includingMonetaryMovement;
  final List<MonetaryMovementType> excludingMonetaryMovement;

  ExpensesByCategorySettingModel(
      {@required ReportingPeriodType periodType,
      this.includingCategory,
      this.includingMonetaryMovement,
      this.excludingMonetaryMovement})
      : startDate = getPeriodReport(periodType)["startDate"],
        endDate = getPeriodReport(periodType)["endDate"];
}
*/
