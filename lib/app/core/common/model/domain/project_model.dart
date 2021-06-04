import 'package:uuid/uuid.dart';

class ProjectDomainModel {
  final String id;
  String? parentId;
  String? fullPatch;
  final bool isNew;
  String projectName;
  String? description;

  ProjectDomainModel._(
      {required this.id,
      required this.parentId,
      required this.fullPatch,
      required this.isNew,
      required this.projectName,
      this.description});

  factory ProjectDomainModel({String? id, String? parentId, String? fullPatch, required String projectName, String? description}) {
    bool isNew = false;
    if (id == null) {
      id = Uuid().v4();
      isNew = true;
    }
    if (parentId == null && isNew) {
      parentId = 'root';
    }
    return ProjectDomainModel._(
        id: id, parentId: parentId, fullPatch: fullPatch, isNew: isNew, projectName: projectName, description: description);
  }
}
