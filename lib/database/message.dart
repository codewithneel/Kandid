

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kandid/database/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

/// This comment blocks an undesirable naming convention warning from showing up
// ignore_for_file: non_constant_identifier_names

Future<void> messageNew(String sender_id, String chat_id, String text) async {

  //TODO: check length of text

  final message = ParseObject('Message')
    ..set('senderId', sender_id)
    ..set('chatId', chat_id)
    ..set('text', text);
  // back4app saves date time as "createAt"
  await message.save();

  debugPrint(message.toString());
}

void messageRemove(String follower_id, String followed_id) async {
  //TODO: this is unnecessary for the MVP
}

/// Returns tuple [ sender username, message, Date_time ]
Future<List<dynamic>?> messageGetTuple(String message_id) async {

  List<dynamic>? ret;

  try {
    var query = QueryBuilder<ParseObject>(ParseObject('Message'));
    query.whereEqualTo("objectId", message_id);
    final ParseResponse apiResponse = await query.query();
    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        ret =  [ obj["senderId"], obj["text"], obj["createdAt"] ] ;
        ret[0] = userGetUsername(ret[0]);
      }
    }
  }
  catch (e) {
    debugPrint("Failed to get Message tuple from message id $message_id\n$e");
  }

  return ret;
}

