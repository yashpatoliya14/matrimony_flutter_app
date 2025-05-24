import 'package:flutter/material.dart';
import 'package:matrimony_flutter/Authentication/user_controllers.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';

class DrawerProvider with ChangeNotifier{
  bool fetched = false;


  Map<String, dynamic>? userDetail;
  Future<void> getProfileDetails([refresh=false]) async {
    if(fetched && refresh==false)
      return;
    UserOperations userOperations = UserOperations();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userDetail = await userOperations.getUserByEmail(
      email: prefs.getString(EMAIL).toString(),
    );
    fetched=true;
  }
}