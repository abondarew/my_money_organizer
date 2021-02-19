import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/exceptions.dart';

class AccountDeleteException extends BaseCommandException{
  final String name;
  final String message;

  AccountDeleteException({
    @required this.name,
    @required this.message
});
}