import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:userlist_internsathi/constants/constant.dart';
import 'package:userlist_internsathi/models/user_model.dart';

class UserService {
  getUsers({required BuildContext context}) async {
    UserModel userModel = UserModel();
    List<UserModel> userList = [];

    try {
      final response = await http.get(Uri.parse(apiUrl));
      log(response.body);
      if (response.statusCode == 200) {
        userList = userModelFromJson(response.body);
        log(userList.toString());
        return userList;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.statusCode.toString()),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
