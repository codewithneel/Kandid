/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:kandid/database/user.dart';
import 'package:kandid/templates/other_profile.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/templates/comments_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void goToOtherProfile(String post_id, BuildContext context) async {
  String? id = await userGetPostUserId(post_id);
  if (id != null) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OtherProfileScreen(user_id: id)));
  }
}

class PostCard extends StatefulWidget {
  final postId;
  PostCard({Key? key, required this.postId}) : super(key: key);
  var image_file;

  @override
  _PostCardScreenState createState() => _PostCardScreenState();
}

class _PostCardScreenState extends State<PostCard> {
  Future<ParseFileBase?> getImage() async {
    String? user = await userGetPostUserId(widget.postId);
    return await userGetImage(user!);
  }

  Future<void> likePost(String post_id) async {
    userLike(post_id);

    setState(() {});
  }
  //   int status = await userLike(post_id);
  //   //if (status == 1) {
  //   //   setState(() {
  //   //     Icon(
  //   //       Icons.favorite,
  //   //       color: Colors.red,
  //   //     );
  //   //   });
  //   // } else if (status == 0) {
  //   //   setState(() {
  //   //     Icon(
  //   //       Icons.favorite,
  //   //       color: Colors.white,
  //   //     );
  //   //   });
  //   // }
  //   if (status == 1) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> _notifier = ValueNotifier(false);
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          InkWell(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16)
                        .copyWith(right: 0),
                child: Row(
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
                              widget.image_file =
                                  snapshot.data as ParseFileBase;
                              return CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      widget.image_file.url.toString()),
                                  radius: 16);
                            default:
                              return const Text('default?');
                          }
                        }),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                                future: userGetPostUsername(widget.postId),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.active:
                                    case ConnectionState.waiting:
                                      return const Text('');
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
              onTap: () => goToOtherProfile(widget.postId, context)),

          //image section
          //AspectRatio(
          //aspectRatio: 21 / 9,
          Container(
            height: MediaQuery.of(context).size.height * .65,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.fill,
              //height: MediaQuery.of(context).size.height * 0.45,
              //width: double.infinity,
              //width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future: userGetPostImage(widget.postId),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                      //return const CircularProgressIndicator();
                      case ConnectionState.done:
                        if (snapshot.data == null) {
                          return const Text("");
                        }
                        widget.image_file = snapshot.data as ParseFileBase;
                        return Image.network(widget.image_file.url.toString());
                      default:
                        return const Text('default?');
                    }
                  }),
            ),
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
                      onPressed: () => {likePost(widget.postId)},

                      icon: Icon(
                        Icons.favorite_outline,
                        color: Colors.black,
                      ),
                      label: FutureBuilder(
                          future: getLikesCount(widget.postId),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.active:
                              case ConnectionState.waiting:
                                return const Text('');
                              case ConnectionState.done:
                                if (snapshot.data == 1) {
                                  return Text(
                                    snapshot.data.toString() + " like",
                                    style: TextStyle(color: primaryColor),
                                  );
                                } else {
                                  return Text(
                                    snapshot.data.toString() + " likes",
                                    style: TextStyle(color: primaryColor),
                                  );
                                }

                              default:
                                return const Text('default?');
                            }
                          }),

                      // label: const Text(
                      //   'Likes',
                      //   style: TextStyle(color: primaryColor),
                      // ),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                                  post_Id: widget.postId,
                                ))),
                      },
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
                // FutureBuilder(
                //     future: getLikesCount(postId),
                //     builder: (context, snapshot) {
                //       switch (snapshot.connectionState) {
                //         case ConnectionState.active:
                //         case ConnectionState.waiting:
                //           return const Text('Loading...');
                //         case ConnectionState.done:
                //           return Text(snapshot.data.toString() + " likes");
                //         default:
                //           return const Text('default?');
                //       }
                //     }),
                Row(
                  children: [
                    FutureBuilder(
                        future: userGetPostUsername(widget.postId),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return const Text('');
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
                        future: userGetCaption(widget.postId),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return const Text('');
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CommentsScreen(
                              post_Id: widget.postId,
                            )));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: FutureBuilder(
                        //future: displayNumberOfComments(),
                        future: getNumberOfComments(widget.postId),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return const Text('');
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
