// This file is responsible for rendering the template_my_user found in the Figma File

import 'package:flutter/material.dart';
import 'package:kandid/templates/message_screen.dart';
import 'package:kandid/templates/single_post_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../database/user.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:kandid/utils/colors.dart';

import '../widgets/post_card.dart';
import 'followers_screen.dart';
import 'following_screen.dart';

/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var image_file;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<ParseFileBase?> getImage() async {
    String user = await getCurrentUser();
    return await userGetImage(user);
  }

  String Bio = "Humanitarian | BJJ | NJIT Alum";

  var followers = 14;
  var following = 43;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,

        centerTitle: true,
        backgroundColor: Colors.white,
        title: FutureBuilder(
            future: myProfileGetUsername(),
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
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) => const MessageScreen(),
          //         ),
          //       );
          //     },
          //     child: const Icon(Icons.message_outlined, color: Colors.black),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 24.0, 0.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              child: const Icon(Icons.settings, color: Colors.black),
            ),
          ),
        ],
      ),
      body: ListView(
        //scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: SingleChildScrollView(
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
                                widget.image_file =
                                    snapshot.data as ParseFileBase;
                                return CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        widget.image_file.url.toString()),
                                    radius: 40);
                              default:
                                return const Text('default?');
                            }
                          }),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45.0, 0.0, 0.0, 20.0),
                                    child: FutureBuilder(
                                        future: myProfileGetBio(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FollowersPage()))
                                  },
                                  child: FutureBuilder(
                                      future: myProfileGetFollowerCount(),
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.active:
                                          case ConnectionState.waiting:
                                            return buildStatColumn(0, "");
                                          case ConnectionState.done:
                                            return buildStatColumn(
                                                int.parse(
                                                    snapshot.data.toString()),
                                                "followers");
                                          default:
                                            return buildStatColumn(
                                                -2, "default?");
                                        }
                                      }),
                                ),
                                GestureDetector(
                                    onTap: () => {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FollowingPage()))
                                        },
                                    child: FutureBuilder(
                                        future: myProfileGetFollowingCount(),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.active:
                                            case ConnectionState.waiting:
                                              return buildStatColumn(0, "");
                                            case ConnectionState.done:
                                              return buildStatColumn(
                                                  int.parse(
                                                      snapshot.data.toString()),
                                                  "following");
                                            default:
                                              return buildStatColumn(
                                                  -2, "default?");
                                          }
                                        }))
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
          ),
          FutureBuilder<List<dynamic>?>(
              future: userGetPostsProfile(),
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

Future<String> myProfileGetUsername() async {
  String user_id = await getCurrentUser();
  dynamic ret = await userGetUsername(user_id);
  if (ret != null) {
    return ret;
  }
  return "<No Username>";
}

Future<String> myProfileGetBio() async {
  String user_id = await getCurrentUser();
  dynamic ret = await userGetBio(user_id);
  if (ret != null) {
    return ret;
  }
  return "<No Bio Found>";
}

Future<int> myProfileGetFollowerCount() async {
  String user_id = await getCurrentUser();
  return await userGetFollowerCount(user_id);
}

Future<int> myProfileGetFollowingCount() async {
  String user_id = await getCurrentUser();
  return await userGetFollowingCount(user_id);
}
