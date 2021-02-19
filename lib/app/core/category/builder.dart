import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/category/command/dispatcher/command_dispatcher.dart';
import 'package:mymoneyorganizer/app/core/category/command/handler/create_command_handler.dart';
import 'package:mymoneyorganizer/app/core/category/command/validator/create_validator.dart';
import 'package:mymoneyorganizer/app/core/category/repository/base_repository.dart';

class CategoryCoreBuilder{
  static CategoryCommandDispatcher buildCategoryCommandDispatcher({@required CategoryBaseRepository repository}){
    final CategoryCreateCommandHandler createCommandHandler = CategoryCreateCommandHandler(repository: repository, validator: CategoryCreateCommandValidator());

    return CategoryCommandDispatcher();
  }
}