import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/core/common/model/domain/category_model.dart';
import 'package:mymoneyorganizer/core/common/model/domain/project_model.dart';
import 'package:mymoneyorganizer/core/common/model/domain/uses_currency_model.dart';
import 'package:uuid/uuid.dart';

class BudgetDomainModel {
  final String id;
  String budgetName;
  DateTime startDate;
  DateTime endDate;
  bool isClosed;
  bool isPeriodic;
  String periodRules;
  double requiredAmount;
  UsesCurrencyDomainModel currency;
  List<ProjectDomainModel> includingProjects;
  List<ProjectDomainModel> excludingProjects;
  List<CategoryDomainModel> includingCategories;

  BudgetDomainModel._(
      {@required this.id,
      @required this.budgetName,
      @required this.startDate,
      this.endDate,
      @required this.isClosed,
      @required this.isPeriodic,
      this.periodRules,
      @required this.requiredAmount,
      @required this.currency,
      this.includingProjects,
      this.excludingProjects,
      this.includingCategories});

  factory BudgetDomainModel(
      {String id,
      @required String budgetName,
      @required DateTime startDate,
      DateTime endDate,
      @required bool isClosed,
      @required bool isPeriodic,
      String periodRules,
      @required double requiredAmount,
      @required UsesCurrencyDomainModel currency,
      List<ProjectDomainModel> includingProjects,
      List<ProjectDomainModel> excludingProjects,
      List<CategoryDomainModel> includingCategories}) {
    if (id == null) {
      id = Uuid().v4();
    }
    return BudgetDomainModel._(
        id: id,
        budgetName: budgetName,
        startDate: startDate,
        endDate: endDate,
        isClosed: isClosed,
        isPeriodic: isPeriodic,
        periodRules: periodRules,
        requiredAmount: requiredAmount,
        currency: currency,
        includingProjects: includingProjects,
        excludingProjects: excludingProjects,
        includingCategories: includingCategories);
  }
}
