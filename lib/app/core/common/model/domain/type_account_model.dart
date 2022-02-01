import 'package:mymoneyorganizer/app/core/common/const/account_classes.dart';
import 'package:mymoneyorganizer/app/core/common/model/domain/base_domain_model.dart';
import 'package:uuid/uuid.dart';

class TypeAccountDomainModel implements BaseDomainModel {
  final String id;
  String name;
  AccountClasses? accountClasses;

  TypeAccountDomainModel._({
    required this.id,
    required this.name,
    required this.accountClasses,
  });

  factory TypeAccountDomainModel({
    String? id,
    required String name,
    required AccountClasses accountClasses,
  }) {
    id ??= const Uuid().v4();
    return TypeAccountDomainModel._(
      id: id,
      name: name,
      accountClasses: accountClasses,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'accountClasses': accountClasses,
    };
    return map;
  }
}
