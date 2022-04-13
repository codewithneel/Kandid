/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:kandid/database/user.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/templates/comments_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PostCard extends StatelessWidget {
  final postId;
  PostCard({Key? key, required this.postId}) : super(key: key);
  var image_file;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1648405679817-325c7da58074?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            future: userGetPostUsername(postId),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.active:
                                case ConnectionState.waiting:
                                  return const Text('Loading...');
                                case ConnectionState.done:
                                  return SelectableText.rich(
                                    TextSpan(
                                        text: snapshot.data.toString(),
                                        style: const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold)),
                                  );
                                default:
                                  return const Text('default?');
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          //image section

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: FutureBuilder(
                future: userGetPostImage(postId),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Text("loading...");
                    case ConnectionState.done:
                      if (snapshot.data == null) {
                        return Text("No image found");
                      }
                      image_file = snapshot.data as ParseFileBase;
                      return Image.network(image_file.url.toString());
                    default:
                      return const Text('default?');
                  }
                }),
          ),

          //Like and comments section
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     IconButton(
          //       onPressed: () {},
          //       icon: const Icon(
          //         Icons.favorite,
          //         color: Colors.red,
          //       ),
          //     ),
          //     IconButton(
          //       onPressed: () => Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) => CommentsScreen(post_Id: postId),
          //         ),
          //       ),
          //       icon: const Icon(
          //         Icons.comment_outlined,
          //         color: primaryColor,
          //       ),
          //     ),
          //   ],
          // ),
          //Descriptions and view commnets

          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      onPressed: () => {userLike(postId)},
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      label: const Text(
                        'Likes',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      onPressed: () => {},
                      icon: Icon(
                        Icons.comment_outlined,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Comments',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '20 Likes',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Row(
                  children: [
                    FutureBuilder(
                        future: userGetPostUsername(postId),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return const Text('Loading...');
                            case ConnectionState.done:
                              return SelectableText.rich(
                                TextSpan(
                                    text: snapshot.data.toString(),
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold)),
                              );
                            default:
                              return const Text('default?');
                          }
                        }),
                    const SizedBox(width: 5),
                    FutureBuilder(
                        //future: displayCaption(),
                        future: userGetCaption(postId),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return const Text('Loading...');
                            case ConnectionState.done:
                              return SelectableText.rich(
                                TextSpan(
                                  text: snapshot.data.toString(),
                                ),
                              );
                            default:
                              return const Text('default?');
                          }
                        }),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: FutureBuilder(
                        //future: displayNumberOfComments(),
                        future: getNumberOfComments(postId),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return const Text('Loading...');
                            case ConnectionState.done:
                              if (snapshot.data == null) {
                                return const Text('');
                              }
                              return Text("View all " +
                                  snapshot.data.toString() +
                                  " comments");
                            default:
                              return const Text('default?');
                          }
                        }), //Text(
                    //'view all 20 comments',
                    //style:
                    //    const TextStyle(fontSize: 16, color: secondaryColor),
                    //),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
