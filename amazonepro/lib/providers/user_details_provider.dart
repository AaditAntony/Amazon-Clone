import 'package:amazonepro/model/user_details_model.dart';
import 'package:amazonepro/resources/cloudFirestore_methods.dart';
import 'package:flutter/material.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;
  UserDetailsProvider()
      : userDetails = UserDetailsModel(name: "loading", address: "loading");

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
