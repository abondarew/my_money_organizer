
import 'package:mymoneyorganizer/app/core/common/model/read/reports/expenses_by_category.dart';

abstract class ExpenseByCategoryBaseRepository{

  Future <List<ExpensesByCategoryModel>> getListExpenseCategory(ExpensesByCategorySettingModel settingModel);
}