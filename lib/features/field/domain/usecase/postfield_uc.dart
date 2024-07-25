import 'package:flutter/material.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/features/field/domain/repositories/field_repo.dart';

import '../../../../shared/constant/cutom_res.dart';

class PostFieldUC {
  final FieldRepo fieldRepo;

  PostFieldUC({required this.fieldRepo});

  Future<ResponseData> call(FieldEntity fieldEntity) {
    return fieldRepo.postField(fieldEntity);
  }
}
