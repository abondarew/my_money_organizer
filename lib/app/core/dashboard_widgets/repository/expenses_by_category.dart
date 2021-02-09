import 'package:mymoneyorganizer/app/core/common/model/domain/report_model/expenses_by_category.dart';

abstract class ExpenseByCategoryBaseRepository{

  Future <List<ExpensesByCategoryModel>> getListCategory(ExpensesByCategorySettingModel settingModel);
}