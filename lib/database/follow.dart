// follows database library
// This file contains functions related to follow relationships between users

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

// Stream<String> getFollowers(String user_id) async* {
//
//   var ret = <Future<String>>[];
//
//   var query = QueryBuilder<ParseObject>(ParseObject("Follow"));
//   query.whereEqualTo("target", user_id);
//   final ParseResponse apiResponse = await query.query();
//   if (apiResponse.success && apiResponse.results != null) {
//     for (ParseUser user in apiResponse.results!) {
//        ret.add(user["objectId"]);
//     }
//   }
//   return ret;
// }



void newFollow(){}

void removeFollow(){}