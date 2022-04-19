// Follow database library
// This file contains functions related to Follow entities in the database

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

/// This comment blocks an undesirable naming convention warning from showing up
// ignore_for_file: non_constant_identifier_names


Future<void> newFollow(String follower_id, String followed_id) async {

  removeFollow(follower_id, followed_id);
  //TODO: CHECK IF FOLLOW IS ALREADY IN DATABASE (we don't want duplicate follows)

  final follow = ParseObject('Follow')
    ..set('follower', follower_id)
    ..set('followed', followed_id);
  await follow.save();

  debugPrint(follow.toString());
}

void removeFollow(String follower_id, String followed_id) async {
  final parseQuery = QueryBuilder<ParseObject>(ParseObject('Follow'));
  parseQuery.whereContains('followed', followed_id);
  parseQuery.whereContains('follower', follower_id);

  final ParseResponse apiResponse = await parseQuery.query();
  if (apiResponse.success && apiResponse.results != null) {
    for (ParseObject o in apiResponse.results!) {
      debugPrint(o.toString());
    }
  }
}

// TODO: THE BELOW FUNCTIONS need to return streams not futures

/// This returns everyone following the inputted user_id
Future<List<String>?> getFollowers(String user_id) async {
  List<String> ret = [];
  final parseQuery = QueryBuilder<ParseObject>(ParseObject('Follow'));
  parseQuery.whereContains('followed', user_id);

  final ParseResponse apiResponse = await parseQuery.query();
  if (apiResponse.success && apiResponse.results != null) {
    for( ParseObject o in apiResponse.results!) {
      ret.add(o["follower"]); // TODO: ERROR CHECK is probably necessary here
    }
    return ret;
  }
  return null;
}

/// This returns everyone inputted user_id is following
Future<List<String>?> getFollowing(String user_id) async {
  List<String> ret = [];
  final parseQuery = QueryBuilder<ParseObject>(ParseObject('Follow'));
  parseQuery.whereContains('follower', user_id);

  final ParseResponse apiResponse = await parseQuery.query();
  if (apiResponse.success && apiResponse.results != null) {
    for( ParseObject o in apiResponse.results!) {
      ret.add(o["followed"]); // TODO: ERROR CHECK is probably necessary here
    }
    return ret;
  }
  return null;
}

/**Streams should be used above, but I don't know if this is done properly**/
// Stream<dynamic>? getFollowers(String followed) async* {
//   final parseQuery = QueryBuilder<ParseObject>(ParseObject('Follow'));
//   parseQuery.whereContains('followed', followed);
//
//   final ParseResponse apiResponse = await parseQuery.query();
//   if (apiResponse.success && apiResponse.results != null) {
//     yield apiResponse.results;
//   }
//   yield null;
// }