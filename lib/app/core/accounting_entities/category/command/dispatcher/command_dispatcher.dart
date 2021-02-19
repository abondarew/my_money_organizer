import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/accounting_entities/category/command/handler/create_command_handler.dart';
import 'package:mymoneyorganizer/app/core/accounting_entities/category/command/handler/delete_command_handler.dart';

class CategoryCommandDispatcher{
  final CategoryCreateCommandHandler createCommandHandler;
  final CategoryDeleteCommandHandler deleteCommandHandler;

  CategoryCommandDispatcher({@required this.createCommandHandler, @required this.deleteCommandHandler});
}