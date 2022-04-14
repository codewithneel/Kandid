// This file is responsible for rendering the template_my_user found in the Figma File

import 'package:flutter/material.dart';
import '../database/user.dart';
import '../widgets/follow_button.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:kandid/utils/colors.dart';

/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names

class OtherProfileScreen extends StatelessWidget {

  final user_id;
  const OtherProfileScreen({Key? key, required this.user_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: FutureBuilder(
            future: userGetUsername(user_id),
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
                                      future: userGetBio(user_id),
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
                                  future: userGetFollowerCount(user_id),
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
                                  future: userGetFollowingCount(user_id),
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
            onTap: () async {
              userFollow(await getCurrentUser(), user_id);
            },
              child: Container(
              child: const Text(
                "Follow",
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
          InkWell(
            onTap: () {
              // TODO: Go to the chat or make new chat
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