import 'package:uuid/uuid.dart';

class DashboardWidgetStorageDomainModel {
  String id;
  String parentId;
  String widgetType;
  String widgetSettings;

  DashboardWidgetStorageDomainModel._({required this.id, required this.parentId, required this.widgetType, required this.widgetSettings});

  factory DashboardWidgetStorageDomainModel({String? id, String? parentId, required String widgetType, required String widgetSettings}) {
    if (id == null) {
      id = Uuid().v4();
    }
    if (parentId == null) {
      parentId = 'root';
    }
    return DashboardWidgetStorageDomainModel._(id: id, parentId: parentId, widgetType: widgetType, widgetSettings: widgetSettings);
  }
}
