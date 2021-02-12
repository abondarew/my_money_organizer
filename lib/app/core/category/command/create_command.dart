import 'package:mymoneyorganizer/app/core/common/base/command/base_command.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/nature_of_costs.dart';

class CategoryCreateCommand extends BaseCommand{
  String id;
  String parentId;
  String name;
  String parentPatch;
  NatureOfCostsDomainModel natureOfCostsDomainModel;
  UriData icoUri;
  bool isProfit;
  bool isSystemCategory;

}