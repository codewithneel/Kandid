
import 'package:flutter/cupertino.dart';
import 'package:kandid/database/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names

/// Creates new Chat entity and returns its objectId
Future<String?> chatNew(String user_id1, String user_id2) async {

  final chat = ParseObject('Chat')
    ..set('listUserIds', [user_id1, user_id2]);
  await chat.save();

  return chat["objectId"];
}

/// Returns objectId of chat between Username1 and username2. Creates a new Chat if it doesn't exist
Future<String?> chatGetIdWithUsernames(String username1, String username2) async {
  String? id1 = await userGetId(username1);
  String? id2 = await userGetId(username2);
  if (id1 == null || id2 == null) { return null; } //TODO: some sort of error message

  return await chatGetIdWithIds(id1, id2);
}

Future<String?> chatGetIdWithIds(String id1, String id2) async {

  try {
    var query = QueryBuilder<ParseObject>(ParseObject('Chat'));
    query.whereArrayContainsAll("listUserIds", [id1, id2]);
    final ParseResponse apiResponse = await query.query();
    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        return obj["objectId"];
      }
    }
  }
  catch (e) {
    debugPrint("Failed to get ID for Chat between $id1 and $id2\n$e");
  }
  return chatNew(id1, id2);
}

/// Returns a String array of Message Id's from chat with chat_id
Future<List<dynamic>?> chatGetMessages(String chat_id) async {
  List<String>? ret = [];

  // TODO: make this function return a stream or limit the number of messages returned

  try {
    var query = QueryBuilder<ParseObject>(ParseObject('Message'));
    query.whereEqualTo("chatId", chat_id);
    query.orderByAscending("createdAt"); // TODO: Check if this is the right way
    final ParseResponse apiResponse = await query.query();
    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        ret.add( obj["objectId"] ) ;
      }
    }
  }
  catch (e) {
    debugPrint("Failed to get Messages from chat id $chat_id\n$e");
  }

  return ret;
}

Future<List<String>?> getChats(String user_id) async {
  List<String>? ret = [];

  try {
    var query = QueryBuilder<ParseObject>(ParseObject('Chat'));
    query.whereArrayContainsAll("listUserIds", [user_id]);
    final ParseResponse apiResponse = await query.query();
    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
          ret.add(obj["objectId"]);
      }
      return ret;
    }
  }
  catch (e) {
    debugPrint("Failed to get ID for Chats for user_id $user_id\n$e");
  }
  return null;

}
