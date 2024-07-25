import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vhack_client/features/machine/data/model/machine_model.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';
import 'package:http/http.dart' as http;
import 'package:vhack_client/shared/constant/cutom_res.dart';

import '../../domain/entity/machine_entity.dart';

abstract class MachineRemoteDatabase {
  Future<ResponseData> postMachine(MachineModel machineModel);
  Future<ResponseData> deleteMachine(MachineModel machineModel);
  Future<List<MachineModel>> getMachines();
  Future<ResponseData> updateMachine(MachineModel machineModel);
}

class MachineRemoteDatabaseImpl implements MachineRemoteDatabase {
  final String machineURL = '${CustomString.baseURL}/machine';
  static final header = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  @override
  Future<ResponseData> deleteMachine(MachineModel machineModel) async {
    final response = await http.delete(
        Uri.parse('$machineURL/${machineModel.machineID}'),
        headers: header);
    final jsonData = jsonDecode(response.body);
    final ref = FirebaseStorage.instance
        .ref()
        .child('machine')
        .child(machineModel.machineOwnerID!)
        .child(machineModel.machineImage!.avatarURLName);

    await ref.delete();

    return ResponseData.fromJson(jsonData);
  }

  @override
  Future<List<MachineModel>> getMachines() async {
    final response = await http.get(Uri.parse(machineURL), headers: header);
    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (jsonData['message'] is List) {
        final List<dynamic> machineList = jsonData['message'];
        return machineList
            .map((machine) => MachineModel.fromJson(machine))
            .toList();
      }
    }

    return [];
  }

  @override
  Future<ResponseData> postMachine(MachineModel machineModel) async {
    final response = await http.post(Uri.parse(machineURL),
        headers: header,
        body: jsonEncode({
          "machineName": machineModel.machineName,
          "machineDesc": machineModel.machineDesc,
          "machineOwnerID": machineModel.machineOwnerID,
          "machineImage": machineModel.machineImage!.toJson(),
          "machinePICsID": machineModel.machinePICsID,
          "machineStatus": machineModel.machineStatus
        }));
    final jsonData = jsonDecode(response.body);

    return ResponseData.fromJson(jsonData);
  }

  @override
  Future<ResponseData> updateMachine(MachineModel machineModel) async {
    final response =
        await http.put(Uri.parse('$machineURL/${machineModel.machineID}'),
            headers: header,
            body: jsonEncode({
              "machineName": machineModel.machineName,
              "machineDesc": machineModel.machineDesc,
              "machineOwnerID": machineModel.machineOwnerID,
              "machineImage": machineModel.machineImage!.toJson(),
              "machinePICsID": machineModel.machinePICsID,
              "machineStatus": machineModel.machineStatus
            }));
    final jsonData = jsonDecode(response.body);
    return ResponseData.fromJson(jsonData);
  }
}
