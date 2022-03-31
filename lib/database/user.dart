// user database library
// This file contains all user related functions using the back4app database
// Examples of functions include: user data creation/editing/retrieval

//import 'dart:html';
//import 'dart:io';

//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'follow.dart' as f;

// This is probably unnecessary but I don't care
Future<String> getCurrentUser() async {
  ParseUser current = await ParseUser.currentUser();
  return current["objectId"];
}

Future<bool> newUser(String username, String email, String password,
    String fname, String lname, DateTime date_of_birth, bool is_private) async {
  if (username == '' || email == '' || password == '') {
    return false;
    throw Exception("Missing one or more fields");
  }
  final user =
      ParseUser.createUser(username.trim(), password.trim(), email.trim());
  var response = await user.signUp();

  if (response.success) {
    user.set("fname", fname.trim());
    user.set("lname", lname.trim());
    user.set("date_of_birth", date_of_birth.toString());
    user.set("bio", "");
    user.set("is_private", is_private);
    user.save();
    debugPrint("Registered Successfully");
    return true;
  }
  //throw Exception("Parse call failed: ${response.error!.message}");
  return false;
}

Future<bool> emailLogin(
  String email,
  String password,
) async {
  if (email == '' || password == '') {
    return false;
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
  } else {
    return false;
  } // email does not exist

  dynamic user = ParseUser(username, password, null);
  if (user == null) {
    debugPrint("Could not create ParseUser");
    return false;
  }

  var response = await user.login();
  if (response.success) {
    debugPrint("Log In Successful for id ${user.get("objectId").toString()}");
    return true;
  }
  debugPrint("Parse call failed: ${response.error!.message}");
  return false;
}

void logout() async {
  dynamic user = await ParseUser.currentUser();
  if (user == null) {
    debugPrint("Tried logging out when not logged in");
    return;
  }
  var response = await user.logout();
  if (response.success) {
    debugPrint("User was successfully logout!");
  } else {
    throw Exception("Failed parse call: ${response.error!.message}");
  }
}

void _userSetter(String attribute, dynamic newValue) async {
  dynamic current = await ParseUser.currentUser();
  if (current == null) {
    debugPrint("Try to set when no one is logged in");
    return;
  }
  current.set(attribute, newValue);
  current.save();
}

////////////////////////////////////////////////////////////////////////////////
// The functions below are probably unnecessary and _userSetter can just be
// used instead, but this way me and anyone working doesn't have to remember
// attribute names.

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

Future<void> userSetPost(ParseFileBase image, String caption) async {
  dynamic user = await ParseUser.currentUser();
  //String userID = user.get('objectID');
  final todo = ParseObject('Posts')
    ..set('userID', '1')
    //..set('userID', '2')
    ..set('caption', caption)
    ..set('image', image);
  await todo.save();
}

void userSetChat() {}

////////////////////////////////////////////////////////////////////////////////

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
  } catch (e) {
    debugPrint("Failed to get $attribute from $user_id\n$e");
  }
  return ret;
}

////////////////////////////////////////////////////////////////////////////////
// The functions below are probably unnecessary and _userQueryExecutor can just
// be used instead, but this way me and anyone working doesn't have to remember
// attribute names.

Future<String?> userGetUsername(String user_id) async {
  return await _userQueryExecutor(user_id, "username");
}

Future<String?> userGetPassword(String user_id) async {
  return await _userQueryExecutor(user_id, "password");
}

Future<String?> userGetEmail(String user_id) async {
  return await _userQueryExecutor(user_id, "email");
}

Future<String?> userGetFirstName(String user_id) async {
  return await _userQueryExecutor(user_id, "fname");
}

Future<String?> userGetLastName(String user_id) async {
  return await _userQueryExecutor(user_id, "lname");
}

// this may be an issue becuase it dob is a DateTime
Future<DateTime?> userGetDob(String user_id) async {
  return await _userQueryExecutor(user_id, "date_of_birth");
}

Future<List> userGetPost() async {
  try {
    var query = QueryBuilder<ParseUser>(ParseUser.forQuery());
    query.whereEqualTo("userID", '1');
    final ParseResponse apiResponse = await query.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseUser user in apiResponse.results!) {
        //return [user['imagePath'], user['caption'], user['createdAt']];
        return [user['image'], user['caption'], user['createdAt']];
      }
    }
  } catch (e) {
    debugPrint("Failed to get post");
  }
  return [];
}

Future<String?> userGetBio(String user_id) async {
  return await _userQueryExecutor(user_id, "bio");
}

Future<String?> userGetPrivacyStatus(String user_id) async {
  return await _userQueryExecutor(user_id, "is_private");
}

////////////////////////////////////////////////////////////////////////////////
// Follow Relationships are all imported by <follow.dart> but they are imported
// here so that all user functionality is in one place with one import

void userFollow(follower, followed) {
  f.newFollow(follower, followed);
}

void userUnfollow(follower, followed) {
  f.removeFollow(follower, followed);
}

Future<List<String>?> userGetFollowers(String user_id) async {
  return await f.getFollowers(user_id);
}

Future<List<String>?> userGetFollowing(String user_id) async {
  return await f.getFollowing(user_id);
}

void userGetChat() {}
void userGetImage() {}
