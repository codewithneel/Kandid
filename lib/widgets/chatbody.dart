import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kandid/templates/chat_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/message_card.dart';
import 'package:kandid/templates/chat_screen.dart';
import '../main.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({Key? key}) : super(key: key);

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
              children: const [
                Text('username',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text('Full Message', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          Text('12:30am', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
