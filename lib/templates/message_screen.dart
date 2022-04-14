import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kandid/database/user.dart';
import 'package:kandid/templates/chat_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/message_card.dart';
import 'package:kandid/widgets/chatbody.dart';
import '../main.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'Messages',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () => Navigator.of(context).push(
        //         MaterialPageRoute(builder: (context) => const chatScreen())),
        //   )
        // ],
      ),
      //body: const MessageCard(),
      body: FutureBuilder<List<dynamic>?>(
          future: userGetChats(),
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
                        MessageCard(chatId: snapshot.data![index].toString()),
                  ),
                );
              default:
                return const Text('default?');
            }
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
        ),
      ),
    );
  }
}
