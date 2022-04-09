/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:kandid/database/user.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/templates/comments_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart';

Future<String?> displayUsername() async {
  String? username = await userGetPostUsername("x0CZfPCfxw");
  return username;
}

Future<String?> displayCaption() async {
  String? caption = await userGetCaption("x0CZfPCfxw");
  return caption;
}

Future<ParseFileBase?> displayImage() async {
  ParseFileBase? image =
      (await userGetPostImage("x0CZfPCfxw")) as ParseFileBase?;
  if (image == null) {
    return null;
  }
  return image;
}

Future<int?> displayNumberOfComments() async {
  int? comment = await getNumberOfComments("x0CZfPCfxw");
  return comment;
}

Future<int?> displayNumber() async {}

class PostCard extends StatelessWidget {
  PostCard({Key? key}) : super(key: key);
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
                CircleAvatar(
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
                            future: displayUsername(),
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
                future: displayImage(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(),
                  ),
                ),
                icon: const Icon(
                  Icons.comment_outlined,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          //Descriptions and view commnets
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '20 Likes',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                FutureBuilder(
                    future: displayUsername(),
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
                    future: displayCaption(),
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: ' This is where the description is placed',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: FutureBuilder(
                        future: displayNumberOfComments(),
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
