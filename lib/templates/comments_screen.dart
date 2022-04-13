import 'package:flutter/material.dart';
import 'package:kandid/database/user.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/comment_card.dart';
import 'package:kandid/widgets/text_field_input.dart';

class CommentsScreen extends StatelessWidget {
  final post_Id;
  CommentsScreen({Key? key, required this.post_Id}) : super(key: key);

  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'Comments',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: false,
      ),
      body: CommentCard(),
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
                  textEditingController: _commentController,
                  hintText: 'Share your thoughts...',
                  textInputType: TextInputType.text,
                ),
              ),
            ),
            InkWell(
              onTap: () => userSetComment(post_Id, _commentController.text),
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
