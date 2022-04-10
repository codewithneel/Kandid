import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kandid/templates/message_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/kandidLogo.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MessageScreen())),
            icon: const Icon(
              //messenger icon in homepage
              Icons.messenger_outline,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: PostCard(),
    );
  }
}
