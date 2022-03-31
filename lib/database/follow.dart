// Follow database library
// This file contains functions related to Follow entities in the database

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

/// ( follower_id, followed_id )
Future<void> newFollow(String follower, String followed) async {

  // CHECK IF FOLLOW IS ALREADY IN DATABASE

  final follow = ParseObject('Follow')
    ..set('follower', follower)
    ..set('followed', followed);

  await follow.save();

  debugPrint(follow.toString());
}

/// ( follower_id, followed_id )
void removeFollow(String follower, String followed) async {
  final parseQuery = QueryBuilder<ParseObject>(ParseObject('Follow'));
  parseQuery.whereContains('followed', followed);
  parseQuery.whereContains('follower', follower);

  final ParseResponse apiResponse = await parseQuery.query();
  if (apiResponse.success && apiResponse.results != null) {
    for (ParseObject o in apiResponse.results!) {
      debugPrint(o.toString());
    }
  }
}

// THE BELOW FUNCTIONS need to return streams in the future

/// This returns everyone following the inputted user_id
Future<List<String>?> getFollowers(String user_id) async {
  List<String> ret = [];
  final parseQuery = QueryBuilder<ParseObject>(ParseObject('Follow'));
  parseQuery.whereContains('followed', user_id);

  final ParseResponse apiResponse = await parseQuery.query();
  if (apiResponse.success && apiResponse.results != null) {
    for( ParseObject o in apiResponse.results!) {
      ret.add(o["follower"]); // ERROR CHECK is probably necessary here
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
      ret.add(o["followed"]); // ERROR CHECK is probably necessary here
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