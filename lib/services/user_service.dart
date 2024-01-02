import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inbound/data/user_api.dart';
import 'package:inbound/models/user.dart';

class UserService extends ChangeNotifier {
  UserApi userApi = UserApi();

  Future<dynamic> findUser(String userId) async {
    User? user;
    debugPrint("Fetch User detail");

    var response = await userApi.getUserByID(userId);

    var data = jsonDecode(response.data);
    print(data);

    if (response.statusCode == 200) {
      user = User.fromJson(data);
    }

    return user;
  }

  Future<dynamic> createUser(dynamic userData) async {
    debugPrint("Create User");

    var response = await userApi.createUser(userData);

    var data = jsonDecode(response.data);
    print(data);

    return null;
  }
}
