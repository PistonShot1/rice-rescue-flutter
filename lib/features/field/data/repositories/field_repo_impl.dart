import 'package:vhack_client/features/field/data/database/field_remote_database.dart';
import 'package:vhack_client/features/field/data/model/field_model.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/features/field/domain/repositories/field_repo.dart';

import '../../../../shared/constant/cutom_res.dart';

class FieldRepoImpl implements FieldRepo {
  final FieldRemoteDatabase fieldRemoteDatabase;

  FieldRepoImpl({required this.fieldRemoteDatabase});

  @override
  Future<ResponseData> deleteField(String fieldID) async {
    return await fieldRemoteDatabase.deleteField(fieldID);
  }

  @override
  Future<List<FieldEntity>> getFields() async {
    final fields = await fieldRemoteDatabase.fetchFields();
    return fields.map((e) => e.toEntity()).toList();
  }

  @override
  Future<FieldEntity?> getSingleField(FieldEntity fieldEntity) async {
    final fieldToInsert = FieldModel.fromEntity(fieldEntity);
    final field = await fieldRemoteDatabase.getSingleField(fieldToInsert);
    return field!.toEntity();
  }

  @override
  Future<ResponseData> postField(FieldEntity fieldEntity) async {
    final fieldToInsert = FieldModel.fromEntity(fieldEntity);
    return await fieldRemoteDatabase.postField(fieldToInsert);
  }
}
