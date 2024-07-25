import 'dart:convert';

import 'package:vhack_client/features/team/data/model/team_model.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';
import 'package:http/http.dart' as http;
import '../../../../shared/constant/custom_string.dart';

abstract class TeamRemoteDatabase {
  Future<ResponseData> postTeam(TeamModel teamModel);
  Future<ResponseData> deleteTeam(String teamID);
  Future<List<TeamModel>> getTeams();
  Future<TeamModel?> getSingleTeam(String userID);
  Future<ResponseData> updateTeam(TeamModel teamModel);
}

class TeamRemoteDatabaseImpl implements TeamRemoteDatabase {
  final String teamURL = '${CustomString.baseURL}/team';
  static final header = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  @override
  Future<ResponseData> deleteTeam(String teamID) async {
    final response =
        await http.delete(Uri.parse('$teamURL/$teamID'), headers: header);
    final jsonData = jsonDecode(response.body);
    return ResponseData.fromJson(jsonData);
  }

  @override
  Future<List<TeamModel>> getTeams() async {
    final response = await http.get(Uri.parse(teamURL), headers: header);
    final jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonData['message'] is List) {
        final List<dynamic> teamList = jsonData['message'];
        return teamList.map((e) => TeamModel.fromJson(e)).toList();
      }
    }
    return [];
  }

  @override
  Future<ResponseData> postTeam(TeamModel teamModel) async {
    List<Map<String, dynamic>> teamMemberData = [];
    if (teamModel.teamMember != null) {
      teamMemberData =
          teamModel.teamMember!.map((member) => member.toJson()).toList();
    }

    final response = await http.post(Uri.parse(teamURL),
        headers: header,
        body: jsonEncode({
          "teamByID": teamModel.teamByID,
          "teamMember": teamMemberData,
          "teamName": teamModel.teamName
        }));
    final jsonData = jsonDecode(response.body);
    return ResponseData.fromJson(jsonData);
  }

  @override
  Future<TeamModel?> getSingleTeam(String userID) async {
    final response =
        await http.get(Uri.parse('$teamURL/$userID'), headers: header);
    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return TeamModel.fromJson(jsonData['message']);
    }
    return null;
  }

  @override
  Future<ResponseData> updateTeam(TeamModel teamModel) async {
    List<Map<String, dynamic>> teamMemberData = [];
    if (teamModel.teamMember != null) {
      teamMemberData =
          teamModel.teamMember!.map((member) => member.toJson()).toList();
    }
    final response = await http.put(Uri.parse('$teamURL/${teamModel.teamID}'),
        headers: header, body: jsonEncode({"teamMember": teamMemberData}));
    final jsonData = jsonDecode(response.body);

    return ResponseData.fromJson(jsonData['message']);
  }
}
