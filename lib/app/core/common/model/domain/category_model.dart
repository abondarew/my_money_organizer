import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class CategoryDomainModel {
  final String id;
  String parentId;
  String categoryName;
  String idParentPath;
  String natureOfCost;
  UriData icoUri;
  bool isProfit;
  bool isSystemCategory;

  CategoryDomainModel._(
      {@required this.id,
      this.parentId,
      @required this.categoryName,
      @required this.idParentPath,
      this.natureOfCost,
      this.icoUri,
      this.isProfit,
      this.isSystemCategory});

  factory CategoryDomainModel(
      {String id,
      String parentId,
      @required String categoryName,
      @required String idParentPath,
      String natureOfCost,
      UriData icoUri,
      bool isProfit = false,
      bool isSystemCategory = false}) {
    if (id == null) {
      id = Uuid().v4();
    }
    return CategoryDomainModel._(
        id: id,
        parentId: parentId,
        categoryName: categoryName,
        idParentPath: idParentPath,
        natureOfCost: natureOfCost,
        icoUri: icoUri,
        isProfit: isProfit,
        isSystemCategory: isSystemCategory);
  }
}
