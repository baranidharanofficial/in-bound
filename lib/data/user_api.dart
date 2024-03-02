import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inbound/models/user.dart';

class UserApi {
  Future<APIResponse> getUserByID(String userID) async {
    final url = Uri.parse('https://inbound-5gka.onrender.com/users/$userID');

    try {
      final response =
          await http.get(url).timeout(const Duration(seconds: 120));
      debugPrint('API Response: ${response.body}');
      return APIResponse(
        statusCode: response.statusCode,
        data: response.body,
      );
    } catch (e) {
      return handleAPIError(e);
    }
  }

  Future<APIResponse> getConnectsByID(String userID) async {
    final url =
        Uri.parse('https://inbound-5gka.onrender.com/users/$userID/connects');

    try {
      final response =
          await http.get(url).timeout(const Duration(seconds: 120));
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

  Future<APIResponse> addCategory(String userId, String category) async {
    final url = Uri.parse(
        'https://inbound-5gka.onrender.com/users/add-category/$userId/$category');

    print(jsonEncode({}));

    try {
      final response = await http.post(
        url,
        body: jsonEncode({}),
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

  Future<APIResponse> addUserToCategory(
      String userId, String connectId, List<String> categories) async {
    final url = Uri.parse(
        'https://inbound-5gka.onrender.com/users/add-user-to-category/$userId/$connectId');

    // print(userId);
    // print(userId);
    // print({"categories": categories});

    try {
      final response = await http.post(
        url,
        body: jsonEncode({"categories": categories}),
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

  Future<APIResponse> addConnect(userId, connectId) async {
    final url = Uri.parse(
        'https://inbound-5gka.onrender.com/users/$userId/add-connect/$connectId');

    try {
      final response = await http.post(
        url,
        body: jsonEncode({}),
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
