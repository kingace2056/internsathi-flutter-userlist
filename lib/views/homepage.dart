import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:userlist_internsathi/constants/constant.dart';
import 'package:userlist_internsathi/models/user_model.dart';
import 'package:userlist_internsathi/services/user_services.dart';
import 'package:userlist_internsathi/views/user_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserService userService = UserService();

  List<UserModel> userList = [];
  @override
  void initState() {
    // TODO: implement initState
    fetchUsers();
    super.initState();
  }

  fetchUsers() async {
    userList = await userService.getUsers(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.network(logo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: userList.isEmpty ? 5 : userList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return userList.isEmpty
                    ? Shimmer.fromColors(
                        child: Container(
                          height: 30,
                        ),
                        baseColor: Colors.grey,
                        highlightColor: Colors.blueGrey)
                    : Container(
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor),
                        ),
                        height: MediaQuery.of(context).size.height * 0.11,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userList[index].name.toString(),
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  '@' + userList[index].username.toString(),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 131, 131, 131),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                                Text(
                                  userList[index].company!.name.toString(),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 86, 86, 86),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Spacer(),
                            Center(
                                child: IconButton(
                              onPressed: () {
                                log('Pressed');
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return showAlert(
                                        userModel: userList[index],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.info,
                                color: Colors.blueAccent,
                                size: 30,
                              ),
                            ))
                          ],
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
