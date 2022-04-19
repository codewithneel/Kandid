import 'package:flutter/material.dart';
import 'package:kandid/database/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CommentCard extends StatelessWidget {
  final commentId;
  var image_file;

  Future<ParseFileBase?> getImage() async {
    String? user = await userGetCommentUserId(commentId);
    debugPrint(user);
    return await userGetImage(user!);
  }

  CommentCard({Key? key, required this.commentId}) : super(key: key);

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
          FutureBuilder(
              future: getImage(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return const Text('');
                  case ConnectionState.done:
                    if (snapshot.data == null) {
                      return const Text("hi");
                    }
                    image_file = snapshot.data as ParseFileBase;
                    return CircleAvatar(
                        backgroundImage:
                            NetworkImage(image_file.url.toString()),
                        radius: 16);
                  default:
                    return const Text('default?');
                }
              }),
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
                          return const Text('');
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
                          return const Text('');
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
