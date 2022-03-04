// user database library
// This file contains all user related functions using the back4app database
// Examples of functions include: user data creation/editing/retrieval

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../general_tools/alerts.dart';
import '../my_tests/query_tests.dart';

void newUser(BuildContext context, String username, String email, String password,
    String fname, String lname, DateTime date_of_birth, bool is_private) async {

  if (username == '' || email == '' || password == '') {
    showError(context, "Missing one or more fields");
    return;
  }

  username = username.trim();
  email = email.trim();
  password = password.trim();

  final user = ParseUser.createUser(username, password, email);

  var response = await user.signUp();

  if (response.success) {
    user.set("fname", fname.trim());
    user.set("lname", lname.trim());
    user.set("date_of_birth", date_of_birth.toString());
    user.set("bio", "");
    user.set("is_private", is_private);

    final prefs = await SharedPreferences.getInstance();
    var query = QueryBuilder(ParseObject("User"));
    query.whereEqualTo("username", username);
    final ParseResponse apiResponse = await query.query();

    if (apiResponse.success && apiResponse.results != null) {
      // Let's show the results
      for (var o in apiResponse.results!) {
        var obj = o as ParseObject;
        prefs.setString("user_id", obj["objectId"].toString());

      }
    }
    user.save();
    showError(context, {prefs.get("user_id")}.toString() + "hi" );
    //showSuccess(context);
  }
  else {
    showError(context, response.error!.message);
  }
}

void login(BuildContext context, String username, String email, String password,){}

void userSetUsername() {}
void userSetPassword() {}
void userSetEmail() {}
void userSetFname() {}
void userSetLname() {}
void userSetDob() {} // date of birth
void userSetBio() {}
void userSetFollowers() {} // user_ids that are following user
void userSetFollowing() {} //
void userSetPost() {}
void userSetChat() {}
void userSetPrivate() {}
void userSetImage() {}

void userGetUsername() async {
  var query = QueryBuilder(ParseObject("User"));
  final prefs = await SharedPreferences.getInstance();
  final user_id = prefs.getString('objectId');
  query.whereEqualTo("objectId", user_id);
  final ParseResponse apiResponse = await query.query();

  if (apiResponse.success && apiResponse.results != null) {
    // Let's show the results
    for (var o in apiResponse.results!) {
      var obj = o as ParseObject;

      debugPrint("${obj["username"]}");
    }
  }
}

void userGetPassword() async {
  var query = QueryBuilder(ParseObject("User"));
  final prefs = await SharedPreferences.getInstance();
  final user_id = prefs.getString('objectId');
  query.whereEqualTo("objectId", user_id);
  final ParseResponse apiResponse = await query.query();

  if (apiResponse.success && apiResponse.results != null) {
    // Let's show the results
    for (var o in apiResponse.results!) {
      var obj = o as ParseObject;

      debugPrint("${obj["password"]}");
    }
  }
}

void userGetEmail() async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('email');
  debugPrint(email);
}

void userGetFirstName() async {
  var query = QueryBuilder(ParseObject("User"));
  final prefs = await SharedPreferences.getInstance();
  final user_id = prefs.getString('objectId');
  query.whereEqualTo("objectId", user_id);
  final ParseResponse apiResponse = await query.query();

  if (apiResponse.success && apiResponse.results != null) {
    // Let's show the results
    for (var o in apiResponse.results!) {
      var obj = o as ParseObject;

      debugPrint("${obj["fname"]}");
    }
  }
}

void userGetLastName() async {
  var query = QueryBuilder(ParseObject("User"));
  final prefs = await SharedPreferences.getInstance();
  final user_id = prefs.getString('objectId');
  query.whereEqualTo("objectId", user_id);
  final ParseResponse apiResponse = await query.query();

  if (apiResponse.success && apiResponse.results != null) {
    // Let's show the results
    for (var o in apiResponse.results!) {
      var obj = o as ParseObject;

      debugPrint("${obj["lname"]}");
    }
  }
}

void userGetDOB() async {
  var query = QueryBuilder(ParseObject("User"));
  final prefs = await SharedPreferences.getInstance();
  final user_id = prefs.getString('objectId');
  query.whereEqualTo("objectId", user_id);
  final ParseResponse apiResponse = await query.query();

  if (apiResponse.success && apiResponse.results != null) {
    // Let's show the results
    for (var o in apiResponse.results!) {
      var obj = o as ParseObject;

      debugPrint("${obj["dob"]}");
    }
  }
} // date of birth

void userGetBio() async {
  var query = QueryBuilder(ParseObject("User"));
  final prefs = await SharedPreferences.getInstance();
  final user_id = prefs.getString('objectId');
  query.whereEqualTo("objectId", user_id);
  final ParseResponse apiResponse = await query.query();

  if (apiResponse.success && apiResponse.results != null) {
    // Let's show the results
    for (var o in apiResponse.results!) {
      var obj = o as ParseObject;

      debugPrint("${obj["bio"]}");
    }
  }
}

void userGetFollowers() {}
void user_get_following() {}
void user_get_post() {}
void user_get_chat() {}
void user_get_private() {}
void userGetImage() {}
//
// bool verifyLogin(String str /*username or email*/, String password) {
//   return false;
// }
