import 'package:vhack_client/features/field/domain/entity/field_entity.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

abstract class FieldRepo {
  Future<ResponseData> postField(FieldEntity fieldEntity);
  Future<List<FieldEntity>> getFields();
  Future<FieldEntity?> getSingleField(FieldEntity fieldEntity);
  Future<ResponseData> deleteField(String fieldID);
}
