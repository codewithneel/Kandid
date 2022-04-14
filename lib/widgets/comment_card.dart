import 'package:flutter/material.dart';
import 'package:kandid/database/user.dart';

class CommentCard extends StatelessWidget {
  final commentId;
  const CommentCard({Key? key, required this.commentId}) : super(key: key);

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
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //           text: 'username',
                //           style: const TextStyle(
                //               color: Colors.black,
                //               fontWeight: FontWeight.bold)),
                //     ],
                //   ),
                // ),
                FutureBuilder(
                    future: userGetCommentUsername(commentId),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return const Text('Loading...');
                        case ConnectionState.done:
                          return Text(snapshot.data.toString());
                        default:
                          return const Text('default?');
                      }
                    }),
                FutureBuilder(
                    future: userGetComment(commentId),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return const Text('Loading...');
                        case ConnectionState.done:
                          return Text(snapshot.data.toString());
                        // return SelectableText.rich(
                        //   TextSpan(
                        //       text: snapshot.data.toString(),
                        //       style: const TextStyle(
                        //         color: Colors.black,
                        //       )),
                        // );
                        default:
                          return const Text('default?');
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
