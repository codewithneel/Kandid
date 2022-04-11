// This file is responsible for rendering the template_my_user found in the Figma File

import 'package:flutter/material.dart';
import '../database/user.dart';
import '../widgets/follow_button.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:kandid/utils/colors.dart';

/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({Key? key}) : super(key: key);

  @override
  _OtherProfileScreenState createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: FutureBuilder(
            future: displayUsername(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Text('Loading...', style: TextStyle(color: primaryColor));
                case ConnectionState.done:
                  return Text(snapshot.data.toString(), style: const TextStyle(color: primaryColor));
                default:
                  return const Text('default?', style: TextStyle(color: primaryColor));
              }
            }),

        titleSpacing: -30.0,
        elevation: 0,
        actions: [
          Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 24.0, 0.0),
          child: GestureDetector(
            onTap: () {
              // Eventually, go to the Messages template.
              //Navigator.of(context).push(
              //  MaterialPageRoute(
              //    builder: (context) => const SettingsScreen(),
              //  ),
              // );
            },
            child: const Icon(Icons.message_outlined, color: Colors.black),
          ),
          ),
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
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1646112918482-2763d6e12320?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
                      ),
                      radius: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(45.0, 0.0, 0.0, 0.0),
                                  child: FutureBuilder(
                                      future: myProfileGetBio(),
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.active:
                                          case ConnectionState.waiting:
                                            return const Text('Loading...', style: TextStyle(color: primaryColor));
                                          case ConnectionState.done:
                                            return Text(snapshot.data.toString(), style: const TextStyle(color: primaryColor));
                                          default:
                                            return const Text('default?', style: TextStyle(color: primaryColor));
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
                              FutureBuilder(
                                  future: myProfileGetFollowerCount(),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.active:
                                      case ConnectionState.waiting:
                                        return buildStatColumn(0, "loading...");
                                      case ConnectionState.done:
                                        return buildStatColumn(int.parse(snapshot.data.toString()), "followers");
                                      default:
                                        return buildStatColumn(-2, "default?");
                                    }
                                  }),
                              FutureBuilder(
                                  future: myProfileGetFollowingCount(),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.active:
                                      case ConnectionState.waiting:
                                        return buildStatColumn(0, "loading...");
                                      case ConnectionState.done:
                                        return buildStatColumn(int.parse(snapshot.data.toString()), "following");
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
          InkWell(
            onTap: () {
              // Eventually, go to the Messages template.
            },
              child: Container(
              child: const Text(
                "Send Message",
                style: TextStyle(fontWeight: FontWeight.bold, color: mobileBackgroundColor),
              ),
              width: double.infinity,
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




Future<String> displayUsername() async {
  String user_id = await getCurrentUser();
  dynamic ret = await userGetUsername(user_id);
  if (ret != null) {
    return ret;
  }
  return "No User";
}

Future<String> myProfileGetBio() async{
  String user_id = await getCurrentUser();
  dynamic ret = await userGetBio(user_id);
  if (ret != null) {
    return ret;
  }
  return "No Bio Found";
}

Future<int> myProfileGetFollowerCount() async{
  String user_id = await getCurrentUser();
  int? ret = await userGetFollowerCount(user_id);
  if (ret == null) { return -1; }
  return ret;
}

Future<int> myProfileGetFollowingCount() async{
  String user_id = await getCurrentUser();
  int? ret = await userGetFollowingCount(user_id);
  if (ret == null) { return -1; }
  return ret;
}