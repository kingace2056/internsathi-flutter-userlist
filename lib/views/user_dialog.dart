import 'package:flutter/material.dart';
import 'package:userlist_internsathi/constants/constant.dart';
import 'package:userlist_internsathi/models/user_model.dart';

class showAlert extends StatelessWidget {
  final UserModel userModel;

  const showAlert({
    required this.userModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            userModel.name.toString(),
            style: TextStyle(
                color: primaryColor, fontWeight: FontWeight.w800, fontSize: 22),
          ),
          Text(
            '@${userModel.username}',
            style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 15),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                color: primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(userModel.phone.toString())
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(userModel.email.toString())
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_city,
                color: primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(userModel.address!.street.toString() +
                  ', ' +
                  userModel.address!.suite.toString() +
                  ', ' +
                  userModel.address!.city.toString())
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(userModel.address!.geo.lat +
                  ' , ' +
                  userModel.address!.geo.lat)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
                child: Text(
              'Company Details',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            )),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.badge,
                color: primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(userModel.company!.name.toString())
            ],
          ),
        ],
      ),
    );
  }
}
