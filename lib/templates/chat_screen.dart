import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kandid/database/chat.dart';
import 'package:kandid/database/message.dart';
import 'package:kandid/database/user.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/chatbody.dart';
import 'package:kandid/widgets/message_card.dart';
import 'package:kandid/widgets/message_card.dart';
import 'package:kandid/templates/chat_screen.dart';
import 'package:kandid/widgets/text_field_input.dart';
import '../main.dart';

class chatScreen extends StatelessWidget {
  final String chatId;
  chatScreen({Key? key, required this.chatId}) : super(key: key);

  late TextEditingController _messageController = TextEditingController();

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: mobileBackgroundColor,
        title: Row(children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1648405679817-325c7da58074?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
            ),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<dynamic>?>(
                  future: getName(chatId),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return const Text('Loading...');
                      case ConnectionState.done:
                        return const Text("hi");
                      default:
                        return const Text('default?');
                    }
                  }),
              Text(
                "@username",
                style: TextStyle(color: primaryColor, fontSize: 12),
              ),
            ],
          ),
        ]),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: getMessageId(chatId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
                return const Text("loading...");
              case ConnectionState.done:
                if (snapshot.data?[0] == null) {
                  return const Text("No messages");
                }
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (ctx, index) => Container(
                    child:
                        ChatBody(messageId: snapshot.data![index].toString()),
                  ),
                );
              default:
                return const Text('default?');
            }
          }),
      //body: ChatBody(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1648405679817-325c7da58074?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
              ),
              radius: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8.0),
                child: TextFieldInput(
                  textEditingController: _messageController,
                  hintText: 'Write a mesaage...',
                  textInputType: TextInputType.text,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                messageNew(chatId, _messageController.text);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: const Text(
                  'Send',
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
