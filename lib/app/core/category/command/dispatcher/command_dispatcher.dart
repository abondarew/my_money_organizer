import 'package:mymoneyorganizer/app/core/category/command/handler/create_command_handler.dart';
import 'package:mymoneyorganizer/app/core/category/command/handler/delete_command_handler.dart';

class CategoryCommandDispather{
  final CategoryCreateCommandHandler createCommandHandler;
  final CategoryDeleteCommandHandler deleteCommandHandler;

}