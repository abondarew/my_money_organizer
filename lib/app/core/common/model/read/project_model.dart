class ProjectReadModel {
  final String id;
  final String parentId;
  final String projectName;
  final double totalAmount;

  ProjectReadModel({
    required this.id,
    required this.parentId,
    required this.projectName,
    required this.totalAmount,
  });
}
