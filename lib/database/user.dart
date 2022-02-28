// user database library
// This file contains all user related functions using the back4app database
// Examples of functions include: user data creation/editing/retrieval

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../general_tools/alerts.dart';
import '../my_tests/query_tests.dart';


void newUser(BuildContext context, String username, String email, String password) async {

  test();
  return;

  if (username == '' || email == '' || password == '') {
    showError(context, "Missing one or more fields");
    return;
  }

  username  = username.trim();
  email     = email.trim();
  password  = password.trim();

  final user = ParseUser.createUser(username, password, email);

  var response = await user.signUp();

  if (response.success) {
    showSuccess(context);
  } else {
    showError(context, response.error!.message);
  }
}

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

void userGetUsername(String id) {}
void user_get_password() {}
void user_get_email() {}
void user_get_fname() {}
void user_get_lname() {}
void user_get_dob() {} // date of birth
void user_get_bio() {}
void user_get_followers() {}
void user_get_following() {}
void user_get_post() {}
void user_get_chat() {}
void user_get_private() {}
void userGetImage() {}

bool verifyLogin(String str/*username or email*/, String password){ return false;}