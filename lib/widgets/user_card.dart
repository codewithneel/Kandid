/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:kandid/database/user.dart';
import 'package:kandid/templates/followers_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/templates/comments_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserCard extends StatelessWidget {
  final user_id;
  const UserCard({Key? key, required this.user_id}) : super(key: key);

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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            future: userGetUsername(user_id),
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
        ],
      ),
    );
  }
}
