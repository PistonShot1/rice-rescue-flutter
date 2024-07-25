import 'dart:convert';

import 'package:vhack_client/features/field/data/model/field_model.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/constant/cutom_res.dart';

abstract class FieldRemoteDatabase {
  Future<ResponseData> postField(FieldModel fieldModel);
  Future<List<FieldModel>> fetchFields();
  Future<FieldModel?> getSingleField(FieldModel fieldModel);
  Future<ResponseData> deleteField(String fieldID);
}

class FieldRemoteDatabaseImpl implements FieldRemoteDatabase {
  final String fieldURL = '${CustomString.baseURL}/field';

  static final header = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  @override
  Future<ResponseData> deleteField(String fieldID) async {
    final response =
        await http.delete(Uri.parse('$fieldURL/$fieldID'), headers: header);
    final jsonData = jsonDecode(response.body);
    print(jsonData);
    return ResponseData.fromJson(jsonData);
  }

  @override
  Future<List<FieldModel>> fetchFields() async {
    final response = await http.get(Uri.parse(fieldURL), headers: header);
    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (jsonData['message'] is List) {
        final List<dynamic> fieldDataList = jsonData['message'];
        final List<FieldModel> fields =
            fieldDataList.map((item) => FieldModel.fromJson(item)).toList();
        return fields;
      }
    }

    return [];
  }

  @override
  Future<FieldModel?> getSingleField(FieldModel fieldModel) async {
    final response = await http
        .get(Uri.parse('$fieldURL/${fieldModel.fieldID}'), headers: header);
    final jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return FieldModel.fromJson(jsonData['message']);
    } else {
      return null;
    }
  }

  @override
  Future<ResponseData> postField(FieldModel fieldModel) async {
    final response = await http.post(Uri.parse(fieldURL),
        headers: header,
        body: jsonEncode({
          "fieldName": fieldModel.fieldName,
          "fieldCA": fieldModel.fieldCA,
          "fieldOwnerID": fieldModel.fieldOwnerID,
          "fieldPCT": fieldModel.fieldCA,
          "fieldSeedDate": fieldModel.fieldSeedDate!,
          "fieldLocation": fieldModel.fieldLocation
        }));
    final jsonData = jsonDecode(response.body);

    return ResponseData.fromJson(jsonData);
  }
}
