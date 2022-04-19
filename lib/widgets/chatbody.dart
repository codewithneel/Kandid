import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kandid/database/chat.dart';
import 'package:kandid/templates/chat_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/message_card.dart';
import 'package:kandid/templates/chat_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../database/user.dart';
import '../main.dart';

class ChatBody extends StatefulWidget {
  String messageId;
  var image_file;
  ChatBody({Key? key, required this.messageId}) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  Future<ParseFileBase?> getImage() async {
    String? user = await getMessageUserId(widget.messageId);
    debugPrint(user);
    return await userGetImage(user);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
              future: getImage(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return const Text('');
                  case ConnectionState.done:
                    if (snapshot.data == null) {
                      return const Text("hi");
                    }
                    widget.image_file = snapshot.data as ParseFileBase;
                    return CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.image_file.url.toString()),
                        radius: 16);
                  default:
                    return const Text('default?');
                }
              }),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: getMessageIdUser(widget.messageId),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return const Text('');
                        case ConnectionState.done:
                          return SelectableText.rich(
                            TextSpan(
                                text: snapshot.data.toString(),
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold)),
                          );
                        default:
                          return const Text('default?');
                      }
                    }),
                FutureBuilder(
                    future: getMessage(widget.messageId),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return const Text('');
                        case ConnectionState.done:
                          if (snapshot.data.toString() == '') {
                            return Text("no messages");
                          }
                          return Text(snapshot.data.toString());
                        default:
                          return const Text('default?');
                      }
                    }),
              ],
            ),
          ),
          // FutureBuilder(
          //     future: getMessageCreatedAt(widget.messageId),
          //     builder: (context, snapshot) {
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.active:
          //         case ConnectionState.waiting:
          //           return const Text('Loading...');
          //         case ConnectionState.done:
          //           returnDate(TimeOfDay.fromDateTime(snapshot),
          //               style: TextStyle(color: Colors.grey));
          //         default:
          //           return const Text('default?');
          //       }
          //     })
        ],
      ),
    );
  }
}
