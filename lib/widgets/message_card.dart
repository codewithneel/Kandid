import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kandid/database/chat.dart';
import 'package:kandid/database/user.dart';
import 'package:kandid/templates/chat_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/message_card.dart';
import 'package:kandid/widgets/chatbody.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../main.dart';

class MessageCard extends StatefulWidget {
  final chatId;
  var image_file;
  MessageCard({Key? key, required this.chatId}) : super(key: key);

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  Future<ParseFileBase?> getImage() async {
    String? user = await getUserId(widget.chatId);
    debugPrint(user);
    return await userGetImage(user!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
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
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                        future: getUsername(widget.chatId),
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
                    FutureBuilder<List<dynamic>?>(
                        future: recentMessage(widget.chatId),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return const Text('');
                            case ConnectionState.done:
                              if (snapshot.data?[0] == null) {
                                return Text("No messages");
                              }
                              return Text(
                                  snapshot.data?[1] + ": " + snapshot.data?[0]);
                            default:
                              return const Text('default?');
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => chatScreen(chatId: widget.chatId)))
            });
  }

  text(String s, {required TextStyle style}) {}
}
