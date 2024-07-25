import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:vhack_client/features/crop/data/model/crop_model.dart';
import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';
import 'package:http/http.dart' as http;

abstract class CropRemoteDatabase {
  Future<ResponseData> postCrop(CropModel cropModel);
  Future<ResponseData> deleteCrop(CropModel cropModel);
  Future<List<CropModel>> getCrops();
}

class CropRemoteDatabaseImpl implements CropRemoteDatabase {
  final String cropURL = '${CustomString.baseURL}/crop';

  static final header = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  @override
  Future<ResponseData> deleteCrop(CropModel cropModel) async {
    final response = await http
        .delete(Uri.parse('$cropURL/${cropModel.cropID}'), headers: header);
    final jsonData = jsonDecode(response.body);
    final ref = FirebaseStorage.instance
        .ref()
        .child('crop')
        .child(cropModel.cropOwnerID!)
        .child(cropModel.cropImage!.avatarURLName);

    await ref.delete();
    return ResponseData.fromJson(jsonData);
  }

  @override
  Future<List<CropModel>> getCrops() async {
    final response = await http.get(Uri.parse(cropURL), headers: header);
    final jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonData['message'] is List) {
        final List<dynamic> cropList = jsonData['message'];
        return cropList.map((machine) => CropModel.fromJson(machine)).toList();
      }
    }

    return [];
  }

  @override
  Future<ResponseData> postCrop(CropModel cropModel) async {
    final response = await http.post(Uri.parse(cropURL),
        headers: header,
        body: jsonEncode({
          "cropCA": cropModel.cropCA,
          "cropDisease": cropModel.cropDisease,
          "cropNutrient": cropModel.cropNutrient,
          "cropPrecaution": cropModel.cropPrecaution,
          "cropOwnerID": cropModel.cropOwnerID,
          "cropImage": cropModel.cropImage
        }));
    final jsonData = jsonDecode(response.body);
    return ResponseData.fromJson(jsonData);
  }
}
