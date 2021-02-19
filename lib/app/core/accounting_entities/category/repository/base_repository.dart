import 'package:mymoneyorganizer/app/core/common/model/domain/category_model.dart';

abstract class CategoryBaseRepository{
  Future<void> save(CategoryDomainModel categoryDomainModel);


}