import 'dart:convert';

import 'package:vhack_client/features/team/data/model/forum_model.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';
import 'package:http/http.dart' as http;
import '../../../../shared/constant/custom_string.dart';

abstract class ForumRemoteDatabase {
  Future<ResponseData> postForum(ForumModel forumModel);
  Future<ResponseData> deleteForum(String forumID);
  Future<List<ForumModel>> getForums();
}

class ForumRemoteDatabaseImpl implements ForumRemoteDatabase {
  final String forumURL = '${CustomString.baseURL}/forum';
  static final header = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  @override
  Future<ResponseData> deleteForum(String forumID) async {
    final response =
        await http.delete(Uri.parse('$forumURL/$forumID'), headers: header);
    final jsonData = jsonDecode(response.body);
    return ResponseData.fromJson(jsonData);
  }

  @override
  Future<List<ForumModel>> getForums() async {
    final response = await http.get(Uri.parse(forumURL), headers: header);
    final jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonData['message'] is List) {
        final List<dynamic> forumList = jsonData['message'];
        return forumList.map((e) => ForumModel.fromJson(e)).toList();
      }
    }

    return [];
  }

  @override
  Future<ResponseData> postForum(ForumModel forumModel) async {
    print('save');
    final response = await http.post(Uri.parse(forumURL),
        headers: header,
        body: jsonEncode({
          "forumContent": forumModel.forumContent,
          "forumByID": forumModel.forumByID,
          "forumLocation": forumModel.forumLocation
        }));
    final jsonData = jsonDecode(response.body);
    print(response.body);
    return ResponseData.fromJson(jsonData);
  }
}
