import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_handler.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/base_validator.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/category_model.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/category/repository/base_repository.dart';

import '../create_command.dart';

class CategoryCreateCommandHandler extends BaseCommandHandler<CategoryCreateCommand>{
  final CategoryBaseRepository repository;
  final BaseCommandValidator<CategoryCreateCommand> validator;


  CategoryCreateCommandHandler({@required this.repository, @required this.validator});

  @override
  Future<void> execute(CategoryCreateCommand command) {
    this.validator.validate(command);

    CategoryDomainModel categoryDomainModel = CategoryDomainModel(categoryName: null, idParentPath: null);
    this.repository.save(categoryDomainModel);
  }

}