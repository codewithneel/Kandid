// user database library
// This file contains all user related functions using the back4app database
// Examples of functions include: user data creation/editing/retrieval

// USER ENTITY ATTRIBUTES
// User_id
// username
// password
// email
// fname
// lname
// followers
// following
// posts
// chats
// bio
// date of birth
// private/public

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void new_user_helper(var username) async {
  var profile = ParseObject('User');
  profile.set('username', username);
  profile.set('birthDay', DateTime.parse('1966-09-09'));
  profile.set('favoriteFoods', ['Lobster', 'Bread']);
  profile.set('is_private', 1);

  await profile.save();
}

void new_user() {
  new_user_helper("Han Solo");
}

void user_set_username(){}
void user_set_password(){}
void user_set_email(){}
void user_set_fname(){}
void user_set_lname(){}
void user_set_dob(){} // date of birth
void user_set_bio(){}
void user_set_followers(){}
void user_set_following(){}
void user_set_post(){}
void user_set_chat(){}
void user_set_private(){}


void user_get_username(String id){}
void user_get_password(){}
void user_get_email(){}
void user_get_fname(){}
void user_get_lname(){}
void user_get_dob(){} // date of birth
void user_get_bio(){}
void user_get_followers(){}
void user_get_following(){}
void user_get_post(){}
void user_get_chat(){}
void user_get_private(){}