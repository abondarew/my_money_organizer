import 'package:mymoneyorganizer/app/core/common/base/query/base_query.dart';

abstract class BaseQueryDispatcher {
  const BaseQueryDispatcher();

  Future<dynamic> dispatch(BaseQuery query);
}
