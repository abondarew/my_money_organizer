import 'package:flutter/material.dart';
import 'package:mymoneyorganizer/app/core/common/base/command/exceptions.dart';

class CurrencyCreateCommandException extends BaseCommandException {
  final List<String> id;
  final List<String> name;
  final List<String> symbol;
  final List<String> fraction;
  final List<String> avatarColor;

  final String message;

  CurrencyCreateCommandException({@required this.id, @required this.name, @required this.symbol, @required this.fraction, this.avatarColor, this.message});
}
