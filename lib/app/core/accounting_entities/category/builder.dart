import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/accounting_entities/category/command/handler/delete_command_handler.dart';
import 'package:mymoneyorganizer/app/core/accounting_entities/category/repository/base_repository.dart';

import 'command/dispatcher/command_dispatcher.dart';
import 'command/handler/create_command_handler.dart';
import 'command/validator/create_validator.dart';

class CategoryCoreBuilder{
  static CategoryCommandDispatcher buildCategoryCommandDispatcher({@required CategoryBaseRepository repository}){
    final CategoryCreateCommandHandler createCommandHandler = CategoryCreateCommandHandler(repository: repository, validator: CategoryCreateCommandValidator());
    final CategoryDeleteCommandHandler deleteCommandHandler = CategoryDeleteCommandHandler();
    return CategoryCommandDispatcher(createCommandHandler: createCommandHandler, deleteCommandHandler: deleteCommandHandler);
  }
}