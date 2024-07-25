import 'package:flutter/material.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/features/field/domain/repositories/field_repo.dart';

class GetFieldsdUC {
  final FieldRepo fieldRepo;

  GetFieldsdUC({required this.fieldRepo});

  Future<List<FieldEntity>> call() {
    return fieldRepo.getFields();
  }
}
