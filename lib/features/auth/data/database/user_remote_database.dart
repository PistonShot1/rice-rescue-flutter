import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
import 'package:vhack_client/shared/constant/cutom_res.dart';

import '../../../../shared/constant/custom_string.dart';
import '../model/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDatabase {
  Future<String> signIn(UserModel userModel);
  Future<ResponseData> signUp(UserModel userModel);
  Future<String?> getUserData();
  Future<void> signOut();

  Future<List<UserModel>> getUsers();
  Future<UserModel?> getSingleUser(UserModel userModel);
}

class UserRemoteDatabaseImpl implements UserRemoteDatabase {
  String authURL = '${CustomString.baseURL}/auth';
  String userURL = '${CustomString.baseURL}/user';
  String meURL = '${CustomString.baseURL}/getMe';

  static final header = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  @override
  Future<String?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Authorization');

    if (token == '') {
      prefs.setString('Authorization', '');
    }

    http.Response response = await http.get(
      Uri.parse(meURL),
      headers: {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'Authorization': '$token'
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['userID'];
    } else {
      debugPrint('Request failed with status code: ${response.statusCode}');
      debugPrint('Request failed : ${response.body}');
      return null;
    }
  }

  @override
  Future<String> signIn(UserModel userModel) async {
    final response = await http.post(Uri.parse('$authURL/signin'),
        body: jsonEncode({
          'userEmail': userModel.userEmail,
          'userPassword': userModel.userPassword
        }),
        headers: header);
    final jsonData = jsonDecode(response.body);
    print(jsonData);
    if (response.statusCode == 200) {
      String token = jsonData['token'];
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('Authorization', token);
      return jsonData['message'];
    } else {
      return jsonData['message'];
    }
  }

  @override
  Future<void> signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('Authorization', '');
  }

  @override
  Future<ResponseData> signUp(UserModel userModel) async {
    final response = await http.post(Uri.parse('$authURL/signup'),
        body: jsonEncode({
          "userEmail": userModel.userEmail,
          "userPassword": userModel.userPassword,
          "userName": userModel.userName,
          "userAge": userModel.userAge,
          "userDesc": userModel.userDesc,
          "userType": userModel.userType,
          "userRole": userModel.userRole,
          "userExp": userModel.userExp
        }),
        headers: header);

    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      String token = jsonData['token'];
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('Authorization', token);
      return ResponseData.fromJson(jsonData['data']);
    }
    return ResponseData.fromJson(jsonData['data']);
  }

  @override
  Future<UserModel?> getSingleUser(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('Authorization');

    if (token == '') {
      prefs.setString('Authorization', '');
    }

    final response = await http.get(
      Uri.parse('$userURL/${userModel.userID}'),
      headers: {
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
        'Authorization': '$token'
      },
    );

    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonData['message']);
    } else {
      return null;
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse(userURL), headers: header);
    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (jsonData['message'] is List) {
        final List<dynamic> userDataList = jsonData['message'];
        final List<UserModel> listUser =
            userDataList.map((e) => UserModel.fromJson(e)).toList();

        return listUser;
      }
    }
    return [];
  }
}
