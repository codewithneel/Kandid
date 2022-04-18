import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/post_card.dart';

class SinglePostScreen extends StatelessWidget {
  final post_Id;
  SinglePostScreen({Key? key, required this.post_Id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        centerTitle: false,
        backgroundColor: Colors.white,
        title: const Text('Post', style: TextStyle(color: primaryColor)),
      ),
      body: PostCard(postId: post_Id),
    );
  }
}
