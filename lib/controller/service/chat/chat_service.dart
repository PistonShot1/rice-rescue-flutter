import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';
import 'package:http/http.dart' as http;
import 'package:vhack_client/shared/constant/env/env_secrets.dart';
import '../../../model/chat_entity.dart';

abstract class ChatRemoteDatabase {
  Future<String> addChat(String userMessage, List<ChatEntity> chatHistory);
}

class ChatService extends ChatRemoteDatabase {
  @override
  Future<String> addChat(
      String userMessage, List<ChatEntity> chatHistory) async {
    String openaiResponse = '';
    List<Map<String, dynamic>> chatHistoryJson =
        chatHistory.map((chat) => chat.toJson()).toList();

    try {
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${Env.openAIAPIKEY}",
      };
      var body = jsonEncode({
        'model': 'ft:gpt-3.5-turbo-0613:personal::8QGrtZIN',
        'messages': chatHistory,
      });

      var response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: headers,
        body: body,
      );

      debugPrint(response.body);

      if (response.statusCode != 200) {
        return '';
      }
      final jsonData = jsonDecode(response.body);
      openaiResponse = jsonData['choices'][0]['message']['content'];

      return openaiResponse;
    } catch (e) {
      return '';
    }
  }
}
