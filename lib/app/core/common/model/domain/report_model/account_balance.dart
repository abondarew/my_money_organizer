import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/account_model.dart';
import 'contract/dashboard_widget_model_contract.dart';

class AccountBalanceModel implements DashboardWidgetModelContract {
  final AccountReadModel account;
  final double balance;

  AccountBalanceModel({@required this.account, @required this.balance});

}

class AccountBalanceSettingModel implements DashboardWidgetSettingModelContract{
  List<AccountReadModel> accountsList;
}