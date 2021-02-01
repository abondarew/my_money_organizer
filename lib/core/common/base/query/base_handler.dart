import 'package:mymoneyorganizer/core/common/base/query/base_query.dart';

abstract class BaseQueryHandler<Q extends BaseQuery, R> {
  Future<R> execute(Q query);
}
