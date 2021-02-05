import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/contract/dashboard_widget_model_contract.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/account_model.dart';

class AccountBalanceModel implements DashboardWidgetModelContract {
  final AccountReadModel account;
  final double balance;

  AccountBalanceModel({@required this.account, this.balance});
}

class AccountBalanceSettingModel {
  List<AccountReadModel> accountsList;
}