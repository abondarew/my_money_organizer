import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class CategoryDomainModel {
  final String id;
  String parentId;
  String categoryName;
  String idParentPath;
  String natureOfCost;
  bool isProfit;
  bool isSystemCategory;

  CategoryDomainModel._(
      {@required this.id,
      @required this.parentId,
      @required this.categoryName,
      @required this.idParentPath,
      this.natureOfCost,
      this.isProfit,
      @required this.isSystemCategory});

  factory CategoryDomainModel(
      {String id,
      @required String parentId,
      @required String categoryName,
      @required String idParentPath,
      String natureOfCost,
      bool isProfit,
      @required bool isSystemCategory}) {
    if (id == null) {
      id = Uuid().v4();
    }
    return CategoryDomainModel._(
        id: id,
        parentId: parentId,
        categoryName: categoryName,
        idParentPath: idParentPath,
        natureOfCost: natureOfCost,
        isProfit: isProfit,
        isSystemCategory: isSystemCategory);
  }
}
