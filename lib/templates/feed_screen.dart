import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kandid/database/user.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/post_card.dart';

import 'message_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: mobileBackgroundColor,
            centerTitle: false,
            title: SvgPicture.asset(
              'assets/kandidLogo.svg',
              color: primaryColor,
              height: 32,
            ),
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MessageScreen())),
                icon: const Icon(
                  //messenger icon in homepage
                  Icons.messenger_outline,
                  color: primaryColor,
                ),
              ),
            ]),
        body: FutureBuilder<List<dynamic>?>(
            future: userGetPostsFeed(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Text("loading...");
                case ConnectionState.done:
                  if (snapshot.data?[0] == null) {
                    return const Text("Follow users for posts");
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (ctx, index) => PostCard(postId: snapshot.data![index].toString()),
                  );
                default:
                  return const Text('default?');
              }
            })
        //body: PostCard(),
        );
  }
}
