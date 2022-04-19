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
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../main.dart';

class chatScreen extends StatefulWidget {
  final String chatId;
  var image_file;
  chatScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  _chatScreenState createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  late TextEditingController _messageController = TextEditingController();

  Future<ParseFileBase?> getImage() async {
    String? user = await getUserId(widget.chatId);
    return await userGetImage(user!);
  }

  Future<ParseFileBase?> getImage2() async {
    String? user = await getCurrentUser();
    return await userGetImage(user);
  }

  void postMessage(String chatId, String message) async {
    messageNew(chatId, message);
    setState(() {
      _messageController.text = '';
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: mobileBackgroundColor,
        actions: [
          IconButton(
            onPressed: () => setState(() {}),
            icon: const Icon(
              //messenger icon in homepage
              Icons.refresh,
              color: Colors.transparent,
            ),
          ),
        ],
        title: Row(children: [
          FutureBuilder(
              future: getImage(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return const Text('');
                  case ConnectionState.done:
                    if (snapshot.data == null) {
                      return const Text(
                        "hi",
                        style: TextStyle(color: Colors.black),
                      );
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
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: getName(widget.chatId),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return const Text('');
                      case ConnectionState.done:
                        return Text(
                          snapshot.data.toString(),
                          style: TextStyle(color: primaryColor),
                        );
                      default:
                        return const Text('default?');
                    }
                  }),
              FutureBuilder(
                  future: getUsername(widget.chatId),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return const Text('');
                      case ConnectionState.done:
                        return Text(
                          '@' + snapshot.data.toString(),
                          style: TextStyle(color: primaryColor, fontSize: 12),
                        );
                      default:
                        return const Text('default?');
                    }
                  }),
            ],
          ),
        ]),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: getMessageId(widget.chatId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.waiting:
                return const Text("");
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
            FutureBuilder(
                future: getImage2(),
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
                postMessage(widget.chatId, _messageController.text);
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
