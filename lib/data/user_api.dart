import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inbound/models/user.dart';

class UserApi {
  Future<APIResponse> getUserByID(String userID) async {
    final url = Uri.parse('https://inbound-5gka.onrender.com/users');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 30));
      debugPrint('API Response: ${response.body}');
      return APIResponse(
        statusCode: response.statusCode,
        data: response.body,
      );
    } catch (e) {
      return handleAPIError(e);
    }
  }

  Future<APIResponse> createUser(userData) async {
    final url = Uri.parse('https://inbound-5gka.onrender.com/users');

    print(jsonEncode(userData));

    try {
      final response = await http.post(
        url,
        body: jsonEncode(userData),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      debugPrint('API Response: ${response.body}');
      return APIResponse(
        statusCode: response.statusCode,
        data: response.body,
      );
    } catch (e) {
      return handleAPIError(e);
    }
  }
}

APIResponse handleAPIError(err) {
  debugPrint('Error: $err');

  return APIResponse(
    statusCode: 500,
    data: '{"message" : "Something went wrong" }',
  );
}
