import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kandid/database/chat.dart';
import 'package:kandid/templates/chat_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/message_card.dart';
import 'package:kandid/templates/chat_screen.dart';
import '../main.dart';

class ChatBody extends StatefulWidget {
  String messageId;
  ChatBody({Key? key, required this.messageId}) : super(key: key);

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
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
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1648405679817-325c7da58074?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
            ),
            radius: 18,
          ),
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
                          return const Text('Loading...');
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
                          return const Text('Loading...');
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
          Text('12:30am', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
