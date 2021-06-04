import 'package:mymoneyorganizer/app/core/entities_of_accounting/category/command/handler/create_command_handler.dart';
import 'package:mymoneyorganizer/app/core/entities_of_accounting/category/command/handler/delete_command_handler.dart';

class CategoryCommandDispatcher {
  final CategoryCreateCommandHandler createCommandHandler;
  final CategoryDeleteCommandHandler deleteCommandHandler;

  CategoryCommandDispatcher({required this.createCommandHandler, required this.deleteCommandHandler});
}
