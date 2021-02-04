import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class DashboardWidgetDomainModel {
  final String id;
  String parentId;
  int position;
  String widgetSetting;

  factory DashboardWidgetDomainModel(
      {String id, @required String parentId, @required int position, @required String widgetSetting}) {
    if (id == null) {
      id = Uuid().v4();
    }
    return DashboardWidgetDomainModel._(id: id, parentId: parentId, position: position, widgetSetting: widgetSetting);
  }

  DashboardWidgetDomainModel._(
      {@required this.id, @required this.parentId, @required this.position, @required this.widgetSetting});
}

