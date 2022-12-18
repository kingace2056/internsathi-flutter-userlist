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
  List<UserModel> tempList = [];
  List<UserModel> searchList = [];
  @override
  void initState() {
    // TODO: implement initState
    fetchUsers();
    super.initState();
  }

  fetchUsers() async {
    userList = await userService.getUsers(context: context);
    tempList = userList;
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
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                onFieldSubmitted: (value) {
                  searchList.clear();
                  for (int i = 0; i < tempList.length; i++) {
                    if (tempList[i]
                        .name!
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      searchList.add(tempList[i]);
                    }
                    userList = searchList;
                    setState(() {});
                  }
                },
                onChanged: (value) {
                  searchList.clear();
                  for (int i = 0; i < tempList.length; i++) {
                    if (tempList[i]
                        .name!
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      searchList.add(tempList[i]);
                    }
                    userList = searchList;
                    setState(() {});
                  }
                },
                decoration: const InputDecoration(
                    hintText: 'Search',
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: userList.isEmpty ? 5 : userList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return userList.isEmpty
                      ? Shimmer.fromColors(
                          child: Container(
                            height: 30,
                          ),
                          baseColor: Colors.grey,
                          highlightColor: Colors.blueGrey)
                      : Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 15),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 131, 131, 131),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    userList[index].company!.name.toString(),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 86, 86, 86),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const Spacer(),
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
                                icon: const Icon(
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
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
