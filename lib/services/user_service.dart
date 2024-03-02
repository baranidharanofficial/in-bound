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

  Future<User?> createUser(User userData) async {
    User? user;
    debugPrint("Create User");

    var response = await userApi.createUser(userData);

    var data = jsonDecode(response.data);
    print(data);

    if (response.statusCode == 201) {
      user = User.fromJson(data['user']);
      return user;
    }

    return null;
  }

  Future<User?> getUserById(userId) async {
    User? user;
    debugPrint("Get User");

    var response = await userApi.getUserByID(userId);

    var data = jsonDecode(response.data);

    if (response.statusCode == 200) {
      user = User.fromJson(data);
      print(data);
      return user;
    }

    return null;
  }

  Future<Connect> getConnectsById(userId) async {
    Connect connectData = Connect(connects: [], categories: []);
    List<User> users = [];
    List<String> categories = [];
    debugPrint("Get Connects");

    var response = await userApi.getConnectsByID(userId);

    var data = jsonDecode(response.data);

    if (response.statusCode == 200) {
      List<dynamic> usersData = data['data']['connects'];
      users = usersData.map((jsonData) => User.fromJson(jsonData)).toList();

      List<dynamic> categoryData = data['data']['categories'];
      categories = categoryData.map((jsonData) => jsonData.toString()).toList();
      categories.insert(0, 'All');

      connectData = Connect(
        connects: users,
        categories: categories,
      );

      print(connectData);
      return connectData;
    }

    return connectData;
  }

  Future<User?> addConnect(userId, connectId) async {
    // User? user;
    debugPrint("Add Connection");

    var response = await userApi.addConnect(userId, connectId);

    var data = jsonDecode(response.data);

    print(data);
    return null;
  }

  Future<bool> addCategory(String userId, String category) async {
    debugPrint("Add Category");
    var response = await userApi.addCategory(userId, category);
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> addUserToCategory(
      String userId, String connectId, List<String> categories) async {
    debugPrint("Add User To a Category");

    print(categories);

    var response =
        await userApi.addUserToCategory(userId, connectId, categories);

    var data = jsonDecode(response.data);
    print(data);

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
