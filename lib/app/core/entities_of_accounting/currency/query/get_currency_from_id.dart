import 'package:flutter/foundation.dart';
import 'package:mymoneyorganizer/app/core/common/base/query/base_query.dart';

class CurrencyQueryGetFromId extends BaseQuery{
  final String id;

  CurrencyQueryGetFromId({@required this.id});
}