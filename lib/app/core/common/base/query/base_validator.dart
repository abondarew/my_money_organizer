import 'package:mymoneyorganizer/app/core/common/base/query/base_query.dart';

abstract class BaseQueryValidator<Q extends BaseQuery> {
  Future<void> validate(Q query);
}
