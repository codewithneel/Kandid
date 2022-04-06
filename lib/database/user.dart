// user database library
// This file contains all user related functions using the back4app database
// Examples of functions include: user data creation/editing/retrieval
//import 'dart:html';

import 'dart:io';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'follow.dart' as f;
import 'chat.dart' as c;

/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names

// This is probably unnecessary but I don't care
/// Returns the objectId of the current logged in user
Future<String> getCurrentUser() async {
  ParseUser current = await ParseUser.currentUser();
  return current["objectId"];
}

/// Creates a new instance of User in the database
Future<bool> userNew(String username, String email, String password,
    String fname, String lname, DateTime date_of_birth, bool is_private, bio) async {
  if (username == '' || email == '' || password == '') {
    return false;
    // TODO : throw Exception("Missing one or more fields");
  }
  final user =
      ParseUser.createUser(username.trim(), password.trim(), email.trim());
  var response = await user.signUp();

  if (response.success) {
    user.set("fname", fname.trim());
    user.set("lname", lname.trim());
    user.set("date_of_birth", date_of_birth.toString());
    user.set("bio", bio);
    user.set("is_private", is_private);
    user.save();
    debugPrint("Registered Successfully");
    return true;
  }
  // TODO: throw Exception("Parse call failed: ${response.error!.message}");
  return false;
}

Future<bool> emailLogin(
  String email,
  String password,
) async {
  if (email == '' || password == '') {
    return false;
    // TODO: throw Exception("Missing one or more fields");
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

Future<void> userSetPost(ParseFileBase image, String caption) async {
  String user_id = await getCurrentUser();
  final todo = ParseObject('Post')
    ..set('userId', user_id)
    ..set('caption', caption)
    ..set('image', image);
  await todo.save();
}

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
  } 
  catch (e) {
    debugPrint("Failed to get $attribute from $user_id\n$e");
  }
  return ret;
}

Future<String?> userGetId(String username) async{
  String? ret;

  try {
    var query = QueryBuilder<ParseUser>(ParseUser.forQuery());
    query.whereEqualTo("username", username);
    final ParseResponse apiResponse = await query.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseUser user in apiResponse.results!) {
        ret = user["objectId"];
      }
    }
  }
  catch (e) {
    debugPrint("Failed to get ID for $username\n$e");
  }
  return ret;
}

Future<List?> userGetPost(String user_id) async {
  try {
    var query = QueryBuilder<ParseObject>(ParseObject("Post"));
    query.whereEqualTo("userId", user_id);
    final ParseResponse apiResponse = await query.query();

    // TODO : this query is going to return multiple objects but only the first is being returned
    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        //return [user['imagePath'], user['caption'], user['createdAt']];
        return [
          obj['image'],
          obj['caption'],
          obj['createdAt']
        ];
      }
    }
  } catch (e) {
    debugPrint("Failed to get post");
  }
  return null;
}

////////////////////////////////////////////////////////////////////////////////
// The functions below are probably unnecessary and _userQueryExecutor can
// be used instead, but this way me and anyone working doesn't have to remember
// attribute names in the database

Future<String?> userGetUsername(String user_id) async {
  return await _userQueryExecutor(user_id, "username");
}
Future<String?> userGetPassword(String user_id) async {
  return await _userQueryExecutor(user_id, "password");
}
Future<String?>  userGetEmail(String user_id) async {
  return await _userQueryExecutor(user_id, "email");
}
Future<String?> userGetFirstName(String user_id) async {
  return await _userQueryExecutor(user_id, "fname");
}
Future<String?> userGetLastName(String user_id) async {
  return await _userQueryExecutor(user_id, "lname");
}

// this may be an issue because dob is a DateTime
Future<DateTime?> userGetDob(String user_id) async {
  return await _userQueryExecutor(user_id, "date_of_birth");
}



Future<String?> userGetBio(String user_id) async {
  return await _userQueryExecutor(user_id, "bio");
}
Future<String?> userGetPrivacyStatus(String user_id) async {
  return await _userQueryExecutor(user_id, "is_private");
}

void userGetProfileImage() {}

////////////////////////////////////////////////////////////////////////////////
// Follow Relationships are all imported by <follow.dart> & <chat.dart> but they
// are imported here so that all user functionality is in one place

void userFollow(follower_id, followed_id){
  f.newFollow(follower_id, followed_id);
}

void userUnfollow(follower_id, followed_id){
  f.removeFollow(follower_id, followed_id);
}




Future<List<String>?> userGetFollowers(String user_id) async {
  return await f.getFollowers(user_id);
}
Future<List<String>?> userGetFollowing(String user_id) async {
  return await f.getFollowing(user_id);
}

Future<int?> userGetFollowerCount(String user_id) async {
  dynamic list = await f.getFollowers(user_id);
  if(list == null) return null;
  return list.length;
}

Future<int?> userGetFollowingCount(String user_id) async {
  dynamic list = await f.getFollowing(user_id);
  if(list == null) return null;
  return list.length;
}

Future<List<String>?>  userGetChats(String user_id) async {
  return await c.getChats(user_id);
}
