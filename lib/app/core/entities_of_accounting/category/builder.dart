import 'package:mymoneyorganizer/app/core/entities_of_accounting/category/repository/base_repository.dart';

import 'command/dispatcher/command_dispatcher.dart';
import 'command/handler/create_command_handler.dart';
import 'command/handler/delete_command_handler.dart';
import 'command/validator/create_validator.dart';

class CategoryCoreBuilder {
  static CategoryCommandDispatcher buildCategoryCommandDispatcher({required CategoryBaseRepository repository}) {
    final CategoryCreateCommandHandler createCommandHandler =
        CategoryCreateCommandHandler(repository: repository, validator: CategoryCreateCommandValidator());
    final CategoryDeleteCommandHandler deleteCommandHandler = CategoryDeleteCommandHandler();
    return CategoryCommandDispatcher(createCommandHandler: createCommandHandler, deleteCommandHandler: deleteCommandHandler);
  }
}
