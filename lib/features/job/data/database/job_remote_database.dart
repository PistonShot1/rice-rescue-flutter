import 'dart:convert';

import 'package:vhack_client/features/job/data/model/job_model.dart';
import 'package:vhack_client/features/job/domain/entity/job_entity.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';
import 'package:http/http.dart' as http;
import '../../../../shared/constant/custom_string.dart';

abstract class JobRemoteDatabase {
  Future<ResponseData> postJob(JobModel jobModel);
  Future<ResponseData> deleteJob(String jobID);
  Future<List<JobModel>> getJobs();
  Future<JobModel?> getSingleJob(JobModel jobModel);
}

class JobRemoteDatabaseImpl implements JobRemoteDatabase {
  final String jobURL = '${CustomString.baseURL}/job';

  static final header = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  @override
  Future<ResponseData> deleteJob(String jobID) async {
    final response =
        await http.delete(Uri.parse('$jobURL/$jobID'), headers: header);
    final jsonData = jsonDecode(response.body);
    return ResponseData.fromJson(jsonData);
  }

  @override
  Future<List<JobModel>> getJobs() async {
    final response = await http.get(Uri.parse(jobURL), headers: header);
    final jsonData = jsonDecode(response.body);

    if (jsonData['message'] is List) {
      final List<dynamic> jobList = jsonData['message'];
      return jobList.map((job) => JobModel.fromJson(job)).toList();
    }
    return [];
  }

  @override
  Future<JobModel?> getSingleJob(JobModel jobModel) async {
    final response =
        await http.get(Uri.parse('$jobURL/${jobModel.jobID}'), headers: header);
    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return JobModel.fromJson(jsonData['message']);
    } else {
      return null;
    }
  }

  @override
  Future<ResponseData> postJob(JobModel jobModel) async {
    List<Map<String, dynamic>> teamMemberData = [];

    if (jobModel.jobMembers != null) {
      teamMemberData =
          jobModel.jobMembers!.map((member) => member.toJson()).toList();
    }
    final response = await http.post(
      Uri.parse(jobURL),
      headers: header,
      body: jsonEncode({
        "jobName": jobModel.jobName,
        "jobType": jobModel.jobType,
        "jobDesc": jobModel.jobDesc,
        "jobOwnerID": jobModel.jobOwnerID,
        "jobPriority": jobModel.jobPriority,
        "jobDate": jobModel.jobDate,
        "jobFieldID": jobModel.jobFieldID,
        "jobMembers": teamMemberData,
        "jobMachinesID": jobModel.jobMachinesID
      }),
    );

    if (response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      return ResponseData.fromJson(jsonData);
    } else {
      throw Exception('Failed to post job: ${response.statusCode}');
    }
  }
}
