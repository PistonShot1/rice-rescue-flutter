import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:vhack_client/shared/constant/custom_string.dart';
import 'package:vhack_client/shared/constant/env/env_secrets.dart';

class CropServices {
  static final header = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };

  // Function to encode the image
  static String encodeImage(String imagePath) {
    List<int> imageBytes = File(imagePath).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  static Future<String> getPrecaution({required String cropDisease}) async {
    String apiKey = Env.openAIAPIKEY;

    final chatHistory = [
      {
        "role": "system",
        "content":
            "You are a helpful assistant. Your job is to provide a solution for paddy diseases. Limit your response to only 100 WORDS ONLY. REMEMBER THAT! Make a list in 5 steps only. For example 1. bla bla bla. 2. bla blabla"
      }
    ];

    String userInput = cropDisease;
    chatHistory.add({"role": "user", "content": userInput});

    final payload = {
      "model": "ft:gpt-3.5-turbo-0613:personal::8QGrtZIN",
      "messages": chatHistory,
    };

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String openaiResponse = responseData["choices"][0]["message"]["content"];

      print("AI: $openaiResponse");

      return openaiResponse;
    } else {
      print("Error: ${response.statusCode}");
      return "Error";
    }
  }

  static Future<String> getOverallHealth(File imageFile) async {
    String apiKey = Env.openAIAPIKEY;
    String base64Image = base64Encode(imageFile.readAsBytesSync());

    String apiUrl = "https://api.openai.com/v1/chat/completions";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    Map<String, dynamic> payload = {
      "model": "gpt-4-vision-preview",
      "messages": [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text":
                  "Based on this image, generate a response in a percentage only and it is about overall plant health. The image is only about paddy. Keep in mind that you don't have to give accurate. Just wing it BUT in numbers only."
            },
            {
              "type": "image_url",
              "image_url": {"url": "data:image/jpeg;base64,$base64Image"},
            },
          ],
        }
      ],
      "max_tokens": 300,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(payload),
      );

      //  print(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String overallHealth = responseData["choices"][0]["message"]["content"];
        print(overallHealth);
        return overallHealth;
      } else {
        print(response.statusCode);
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  static Future<String> getNurtrient(File imageFile) async {
    String apiKey = Env.openAIAPIKEY;
    String base64Image = base64Encode(imageFile.readAsBytesSync());

    String apiUrl = "https://api.openai.com/v1/chat/completions";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    Map<String, dynamic> payload = {
      "model": "gpt-4-vision-preview",
      "messages": [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text":
                  "You are a helpful assitant. Your only job is to give percentage of nutrient of paddy. If the paddy has sufficient and has perfect color which is green. Respond 100%. However, in othercase, you must write whatever percentage according to that nutrient paddy. REMEMBER 0 MEANS LACK AND 100 MEANS PERFECT. RESPOND IN PERCENTAGE ONLY!!"
            },
            {
              "type": "image_url",
              "image_url": {"url": "data:image/jpeg;base64,$base64Image"},
            },
          ],
        }
      ],
      "max_tokens": 300,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(payload),
      );

      // print(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String cropNutrient = responseData["choices"][0]["message"]["content"];

        return cropNutrient;
      } else {
        print(response.statusCode);
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  static Future<String> getStatusImage(File imageFile) async {
    String apiKey = Env.openAIAPIKEY;
    String base64Image = base64Encode(imageFile.readAsBytesSync());

    String apiUrl = "https://api.openai.com/v1/chat/completions";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    Map<String, dynamic> payload = {
      "model": "gpt-4-vision-preview",
      "messages": [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text":
                  "Your job is to answer yes or no only with caps lock (YES and NO). Respons YES only if the image is about paddy leave regardless whether the paddy got disease or not. Respond NO only if the image isn't even related to paddy.IF the image is about paddy, and it looks overall healthy, simply respond 'YAY' . Remember to respond only ONE SINGLE WORD ONLY."
            },
            {
              "type": "image_url",
              "image_url": {"url": "data:image/jpeg;base64,$base64Image"},
            },
          ],
        }
      ],
      "max_tokens": 300,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(payload),
      );

      print(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String cropNutrient = responseData["choices"][0]["message"]["content"];

        return cropNutrient;
      } else {
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  static Future<String> getDetectedPests(File imageFile) async {
    String apiKey = Env.openAIAPIKEY;
    String base64Image = base64Encode(imageFile.readAsBytesSync());

    String apiUrl = "https://api.openai.com/v1/chat/completions";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    Map<String, dynamic> payload = {
      "model": "gpt-4-vision-preview",
      "messages": [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text":
                  "Your job is to answer yes or no only with caps lock (YES and NO). Respons YES only if the image is about paddy leave regardless whether the paddy got disease or not. Respond NO only if the image isn't even related to paddy. Remember to respond only ONE SINGLE WORD ONLY."
            },
            {
              "type": "image_url",
              "image_url": {"url": "data:image/jpeg;base64,$base64Image"},
            },
          ],
        }
      ],
      "max_tokens": 300,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(payload),
      );

      print(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String cropNutrient = responseData["choices"][0]["message"]["content"];

        return cropNutrient;
      } else {
        print(response.statusCode);
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  static Future<String> runInThread(File selectedImage) async {
    Completer<String> completer = Completer();

    // Run the getStatusImage function in a separate thread
    Future.delayed(Duration.zero, () async {
      try {
        String result = await getDetectedPests(selectedImage);
        completer.complete(result);
      } catch (e) {
        completer.completeError("Error: $e");
      }
    });

    return completer.future;
  }
}
