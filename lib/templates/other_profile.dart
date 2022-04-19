// This file is responsible for rendering the template_my_user found in the Figma File

import 'package:flutter/material.dart';
import 'package:kandid/database/chat.dart';
import 'package:kandid/templates/chat_screen.dart';
import 'package:kandid/templates/single_post_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../database/user.dart';
import '../widgets/follow_button.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:kandid/utils/colors.dart';

import '../widgets/post_card.dart';

/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names

void goToChat(String user_id, BuildContext context) async {
  String id = await chatGetIdWithIds(await getCurrentUser(), user_id);
  debugPrint(id);
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => chatScreen(chatId: id)));
}

class OtherProfileScreen extends StatelessWidget {
  final user_id;
  var image_file;
  OtherProfileScreen({Key? key, required this.user_id}) : super(key: key);

  Future<ParseFileBase?> getImage() async {
    return await userGetImage(user_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: FutureBuilder(
            future: userGetUsername(user_id),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Text('', style: TextStyle(color: primaryColor));
                case ConnectionState.done:
                  return Text(snapshot.data.toString(),
                      style: const TextStyle(color: primaryColor));
                default:
                  return const Text('default?',
                      style: TextStyle(color: primaryColor));
              }
            }),
        titleSpacing: -30.0,
        elevation: 0,
        actions: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(0.0, 0.0, 24.0, 0.0),
          //   child: GestureDetector(
          //     onTap: () {
          //       // Eventually, go to the Messages template.
          //       //Navigator.of(context).push(
          //       //  MaterialPageRoute(
          //       //    builder: (context) => const SettingsScreen(),
          //       //  ),
          //       // );
          //     },
          //     child: const Icon(Icons.message_outlined, color: Colors.black),
          //   ),
          // ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
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
                                        image_file =
                                            snapshot.data as ParseFileBase;
                                        return CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                image_file.url.toString()),
                                            radius: 40);
                                      default:
                                        return const Text('default?');
                                    }
                                  }),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 0.0, 0.0, 20.0),
                                  child: FutureBuilder(
                                      future: userGetBio(user_id),
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.active:
                                          case ConnectionState.waiting:
                                            return const Text('',
                                                style: TextStyle(
                                                    color: primaryColor));
                                          case ConnectionState.done:
                                            return Text(
                                                snapshot.data.toString(),
                                                style: const TextStyle(
                                                    color: primaryColor));
                                          default:
                                            return const Text('default?',
                                                style: TextStyle(
                                                    color: primaryColor));
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  userFollow(await getCurrentUser(), user_id);
                                },
                                child: Container(
                                  child: const Text(
                                    "Follow",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: mobileBackgroundColor),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      color: greenColor),
                                ),
                              ),
                              FutureBuilder(
                                  future: userGetFollowerCount(user_id),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.active:
                                      case ConnectionState.waiting:
                                        return buildStatColumn(0, "");
                                      case ConnectionState.done:
                                        return buildStatColumn(
                                            int.parse(snapshot.data.toString()),
                                            "followers");
                                      default:
                                        return buildStatColumn(-2, "default?");
                                    }
                                  }),
                              FutureBuilder(
                                  future: userGetFollowingCount(user_id),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.active:
                                      case ConnectionState.waiting:
                                        return buildStatColumn(0, "");
                                      case ConnectionState.done:
                                        return buildStatColumn(
                                            int.parse(snapshot.data.toString()),
                                            "following");
                                      default:
                                        return buildStatColumn(-2, "default?");
                                    }
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                //     InkWell(
                //       onTap: () async {
                //         userFollow(await getCurrentUser(), user_id);
                //       },
                //       child: Container(
                //         child: const Text(
                //           "Follow",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               color: mobileBackgroundColor),
                //         ),
                //         width: MediaQuery.of(context).size.width * 0.5,
                //         alignment: Alignment.center,
                //         padding: const EdgeInsets.symmetric(vertical: 8),
                //         decoration: const ShapeDecoration(
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.all(
                //                 Radius.circular(4),
                //               ),
                //             ),
                //             color: greenColor),
                //       ),
                //     ),
                InkWell(
                  onTap: () => goToChat(user_id, context),
                  child: Container(
                    child: const Text(
                      "Message",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mobileBackgroundColor),
                    ),
                    width: MediaQuery.of(context).size.width * 0.875,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        color: greenColor),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<List<dynamic>?>(
              future: userGetPostsOtherProfile(user_id),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return const Text("");
                  case ConnectionState.done:
                    if (snapshot.data?[0] == null) {
                      return const Text("Follow users for posts");
                    }

                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 1.5,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            child: InkWell(
                                child: Container(
                                  child: FutureBuilder(
                                      future: userGetPostImage(
                                          snapshot.data![index].toString()),
                                      builder: (context, snap) {
                                        switch (snap.connectionState) {
                                          case ConnectionState.active:
                                          case ConnectionState.waiting:
                                            return const Text("");
                                          case ConnectionState.done:
                                            if (snap.data == null) {
                                              return const Text(
                                                  "No image found");
                                            }
                                            var image_file =
                                                snap.data as ParseFileBase;
                                            return Image.network(
                                                image_file.url.toString(),
                                                fit: BoxFit.cover);
                                          default:
                                            return const Text('default?');
                                        }
                                      }),
                                ),
                                onTap: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SinglePostScreen(
                                                    post_Id: snapshot
                                                        .data![index]
                                                        .toString(),
                                                  )))
                                    }),
                          );
                        });

                  default:
                    return const Text('default?');
                }
              })
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
