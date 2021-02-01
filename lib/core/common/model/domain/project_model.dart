import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ProjectDomainModel {
  final String id;
  String parentId;
  String projectName;

  ProjectDomainModel._({@required this.id, this.parentId, @required this.projectName});

  factory ProjectDomainModel({String id, String parentId, @required String projectName}) {
    if (id == null) {
      id = Uuid().v4();
    }
    return ProjectDomainModel._(id: id, parentId: parentId, projectName: projectName);
  }
}
