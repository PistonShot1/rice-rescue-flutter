import 'package:flutter/material.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/features/field/domain/repositories/field_repo.dart';

class GetSingleFieldUC {
  final FieldRepo fieldRepo;

  GetSingleFieldUC({required this.fieldRepo});

  Future<FieldEntity?> call(FieldEntity fieldEntity) {
    return fieldRepo.getSingleField(fieldEntity);
  }
}
