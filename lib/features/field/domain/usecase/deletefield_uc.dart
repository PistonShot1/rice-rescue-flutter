import 'package:flutter/material.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/features/field/domain/repositories/field_repo.dart';

import '../../../../shared/constant/cutom_res.dart';

class DeleteFieldUC {
  final FieldRepo fieldRepo;

  DeleteFieldUC({required this.fieldRepo});

  Future<ResponseData> call(String fieldID) {
    return fieldRepo.deleteField(fieldID);
  }
}
