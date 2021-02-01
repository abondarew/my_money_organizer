import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class CategoryDomainModel {
  final String id;
  String parentId;
  String categoryName;
  bool isProfit;
  String idParentPath;
  bool isSystemCategory;
  String uniqueSystemTag;

  CategoryDomainModel._(
      {@required this.id,
      @required this.parentId,
      @required this.categoryName,
      this.isProfit,
      @required this.idParentPath,
      @required this.isSystemCategory,
      this.uniqueSystemTag});

  factory CategoryDomainModel(
      {String id,
      @required String parentId,
      @required String categoryName,
      bool isProfit,
      @required String idParentPath,
      @required bool isSystemCategory,
      String uniqueSystemTag}) {
    if (id == null) {
      id = Uuid().v4();
    }
    return CategoryDomainModel._(
        id: id,
        parentId: parentId,
        categoryName: categoryName,
        isProfit: isProfit,
        idParentPath: idParentPath,
        isSystemCategory: isSystemCategory,
        uniqueSystemTag: uniqueSystemTag);
  }
}
