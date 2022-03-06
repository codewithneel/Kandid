// user database library
// This file contains all user related functions using the back4app database
// Examples of functions include: user data creation/editing/retrieval

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'follow.dart';

Future<String> getCurrentUser() async {
  ParseUser current = await ParseUser.currentUser();
  return current["objectId"];
}

void newUser(String username, String email, String password,
    String fname, String lname, DateTime date_of_birth, bool is_private) async {

  if (username == '' || email == '' || password == '') {
    throw Exception("Missing one or more fields");
    return;
  }
  final user = ParseUser.createUser(username.trim(), password.trim(), email.trim());
  var response = await user.signUp();

  if (response.success) {
    user.set("fname", fname.trim());
    user.set("lname", lname.trim());
    user.set("date_of_birth", date_of_birth.toString());
    user.set("bio", "");
    user.set("is_private", is_private);
    user.save();
    debugPrint("Registered Successfully");
  }
  else {
    throw Exception("Parse call failed: ${response.error!.message}");
  }
}

Future<String> emailLogin(String email, String password,) async {
  if (email == '' || password == '') {
    throw Exception("Missing one or more fields");
  }

  String username = "";
  var query = QueryBuilder<ParseUser>(ParseUser.forQuery());
  query.whereEqualTo("email", email);
  final ParseResponse apiResponse = await query.query();
  if (apiResponse.success && apiResponse.results != null) {
    for (ParseUser user in apiResponse.results!) {
      username = user["username"];
    }
  }
  else { username = " "; } // email does not exist

  final user = ParseUser(username, password, null);
  var response = await user.login();

  ParseUser current = await ParseUser.currentUser();
  if (response.success) {
    debugPrint("Log In Successful for id ${user.get("objectId").toString()}");
  }
  else {
    throw Exception("Parse call failed: ${response.error!.message}");
  }

  return user.get("objectId");
}

void logout() async {
  dynamic user = await ParseUser.currentUser();
  if (user == null){
    debugPrint("Tried logging out when not logged in");
    return;
  }
  var response = await user.logout();
  if (response.success) {
    debugPrint("User was successfully logout!");
  }
  else {
    throw Exception("Failed parse call: ${response.error!.message}");
  }
}

void _userSetter(String attribute, dynamic newValue) async {
  dynamic current = await ParseUser.currentUser();
  if (current == null){
    debugPrint("Try to set when no one is logged in");
    return;
  }
  current.set(attribute, newValue);
  current.save();
}
void userSetUsername(String new_username) {
  _userSetter("username", new_username);
}
void userSetPassword(String new_password) {
  _userSetter("password", new_password);
}
void userSetEmail(String new_email) {
  _userSetter("email", new_email);
}
void userSetFirstName(String new_fname) {
  _userSetter("fname", new_fname);
}
void userSetLastName(String new_lname) {
  _userSetter("lname", new_lname);
}
void userSetBio(String new_bio) {
  _userSetter("bio", new_bio);
}
void userSetPrivacyStatus(bool new_private) {
  _userSetter("is_private", new_private);
}
void userSetDob(DateTime new_dob) {
  _userSetter("date_of_birth", new_dob);
} // date of birth

void userSetImage() {}

void userSetFollowers() {} // user_ids that are following user
void userSetFollowing() {}
void userSetPost() {}
void userSetChat() {}

Future<dynamic> _userQueryExecutor(String user_id, String attribute) async {
  dynamic ret;
  try {
    var query = QueryBuilder<ParseUser>(ParseUser.forQuery());
    query.whereEqualTo("objectId", user_id);
    final ParseResponse apiResponse = await query.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseUser user in apiResponse.results!) {
        ret = user[attribute];
      }
    }
  }
  catch(e){
    debugPrint("Failed to get $attribute from $user_id\n$e");
  }
  return ret;
}

Future<String> userGetUsername(String user_id) async {
  dynamic ret = await _userQueryExecutor(user_id, "username");
  if (ret == null){ return ""; }
  return ret;
}
Future<String> userGetPassword(String user_id) async {
  return await _userQueryExecutor(user_id, "password");
}
Future<String>  userGetEmail(String user_id) async {
  return await _userQueryExecutor(user_id, "email");
}
Future<String> userGetFirstName(String user_id) async {
  return await _userQueryExecutor(user_id, "fname");
}
Future<String> userGetLastName(String user_id) async {
  return await _userQueryExecutor(user_id, "lname");
}
// this may be an issue becuase it dob is a DateTime
Future<DateTime> userGetDob(String user_id) async {
  return await _userQueryExecutor(user_id, "date_of_birth");
}
Future<String> userGetBio(String user_id) async {
  return await _userQueryExecutor(user_id, "bio");
}
Future<String> userGetPrivacyStatus(String user_id) async {
  return await _userQueryExecutor(user_id, "is_private");
}


void userGetFollowers() {}
void userGetFollowing() {}
void userGetPost() {}
void userGetChat() {}
void userGetImage() {}