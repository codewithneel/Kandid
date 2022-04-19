import 'package:flutter/cupertino.dart';
import 'package:kandid/database/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names

/// Creates new Chat entity and returns its objectId
Future<String> chatNew(String user_id1, String user_id2) async {
  final chat = ParseObject('Chat')..set('listUserIds', [user_id1, user_id2]);
  await chat.save();

  return chat["objectId"];
}

/// Returns objectId of chat between Username1 and username2. Creates a new Chat if it doesn't exist
Future<String?> chatGetIdWithUsernames(
    String username1, String username2) async {
  String? id1 = await userGetId(username1);
  String? id2 = await userGetId(username2);
  if (id1 == null || id2 == null) {
    return null;
  } //TODO: some sort of error message

  return await chatGetIdWithIds(id1, id2);
}

Future<String> chatGetIdWithIds(String id1, String id2) async {
  try {
    var query = QueryBuilder<ParseObject>(ParseObject('Chat'));
    query.whereArrayContainsAll("listUserIds", [id1, id2]);
    final ParseResponse apiResponse = await query.query();
    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        return obj["objectId"];
      }
    }
  } catch (e) {
    debugPrint("Failed to get ID for Chat between $id1 and $id2\n$e");
  }
  return await chatNew(id1, id2);
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
        ret.add(obj["objectId"]);
      }
    }
  } catch (e) {
    debugPrint("Failed to get Messages from chat id $chat_id\n$e");
  }

  return ret;
}

Future<List<String>?> getChats() async {
  List<String>? ret = [];
  dynamic user = await getCurrentUser();

  try {
    var query = QueryBuilder<ParseObject>(ParseObject('Chat'));
    query.whereArrayContainsAll("listUserIds", [user]);
    final ParseResponse apiResponse = await query.query();
    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        ret.add(obj["objectId"]);
      }
      return ret;
    }
  } catch (e) {
    debugPrint("Failed to get ID for Chats for user_id $user\n$e");
  }
  return null;
}

Future<String?> getUsername(String chat_id) async {
  try {
    dynamic user = await getCurrentUser();
    var query = QueryBuilder<ParseObject>(ParseObject("Chat"));
    query.whereEqualTo("objectId", chat_id);
    final ParseResponse apiResponse = await query.query();
    List list = [];

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        list = obj['listUserIds'];
        break;
      }

      if (list[0] != user) {
        return await userGetUsername(list[0]);
      } else {
        return await userGetUsername(list[1]);
      }
    }
  } catch (e) {
    debugPrint("Failed to get username");
  }
  return null;
}

Future<String?> getUserId(String chat_id) async {
  try {
    dynamic user = await getCurrentUser();
    var query = QueryBuilder<ParseObject>(ParseObject("Chat"));
    query.whereEqualTo("objectId", chat_id);
    final ParseResponse apiResponse = await query.query();
    List list = [];

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        list = obj['listUserIds'];
        break;
      }

      if (list[0] != user) {
        return await list[0];
      } else {
        return await list[1];
      }
    }
  } catch (e) {
    debugPrint("Failed to get username");
  }
  return null;
}

Future<List?> recentMessage(String chat_id) async {
  try {
    dynamic user = await getCurrentUser();
    var query = QueryBuilder<ParseObject>(ParseObject("Message"));
    query
      ..whereEqualTo("chatId", chat_id)
      ..orderByDescending("createdAt");
    final ParseResponse apiResponse = await query.query();
    List recentMessage = [];

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        if (user == obj['senderId']) {
          return recentMessage = [obj['text'], 'You'];
        } else {
          return recentMessage = [
            obj['text'],
            await userGetUsername(obj['senderId'])
          ];
        }
      }
    }
  } catch (e) {
    debugPrint("Failed to get most recent message");
  }
  return null;
}

Future<String?> getName(String chat_id) async {
  try {
    dynamic user = await getCurrentUser();
    var query = QueryBuilder<ParseObject>(ParseObject("Chat"));
    query.whereEqualTo("objectId", chat_id);
    final ParseResponse apiResponse = await query.query();
    List list = [];

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        list = obj['listUserIds'];
        break;
      }

      if (list[0] != user) {
        String? first = await userGetFirstName(list[0]);
        String? last = await userGetLastName(list[0]);
        String? name = first + ' ' + last;
        return name;
      } else {
        String? first = await userGetFirstName(list[1]);
        String? last = await userGetLastName(list[1]);
        String? name = first + ' ' + last;
        return name;
      }
    }
  } catch (e) {
    debugPrint("Failed to get most recent message");
  }
  return '';
}

Future<List> getMessageId(String chat_id) async {
  try {
    var query = QueryBuilder<ParseObject>(ParseObject("Message"));
    query
      ..whereEqualTo("chatId", chat_id)
      ..orderByAscending('createdAt');
    final ParseResponse apiResponse = await query.query();
    List list = [];

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        list.add(obj.objectId);
      }
      return list;
    }
  } catch (e) {
    debugPrint("Failed to get chat messages");
  }
  return [];
}

Future<String> getMessageIdUser(String message_Id) async {
  try {
    var query = QueryBuilder<ParseObject>(ParseObject("Message"));
    query.whereEqualTo("objectId", message_Id);
    final ParseResponse apiResponse = await query.query();
    String user;

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        user = await userGetUsername(obj['senderId']);
        return user;
      }
    }
  } catch (e) {
    debugPrint("Failed to get username");
  }
  return '';
}

Future<String> getMessageUserId(String message_Id) async {
  try {
    var query = QueryBuilder<ParseObject>(ParseObject("Message"));
    query.whereEqualTo("objectId", message_Id);
    final ParseResponse apiResponse = await query.query();
    String user;

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        user = obj['senderId'];
        return user;
      }
    }
  } catch (e) {
    debugPrint("Failed to get username");
  }
  return '';
}

Future<String> getMessage(String message_Id) async {
  try {
    var query = QueryBuilder<ParseObject>(ParseObject("Message"));
    query.whereEqualTo("objectId", message_Id);
    final ParseResponse apiResponse = await query.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        return obj['text'];
      }
    }
  } catch (e) {
    debugPrint("Failed to get message");
  }
  return '';
}

Future<DateTime?> getMessageCreatedAt(String message_Id) async {
  try {
    var query = QueryBuilder<ParseObject>(ParseObject("Message"));
    query.whereEqualTo("objectId", message_Id);
    final ParseResponse apiResponse = await query.query();

    if (apiResponse.success && apiResponse.results != null) {
      for (ParseObject obj in apiResponse.results!) {
        debugPrint(obj['createdAt'] + 'hi');
        return obj['createdAt'];
      }
    }
  } catch (e) {
    debugPrint("Failed to get time");
  }
  return null;
}
