import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kandid/database/user.dart';

import '../utils/colors.dart';
import '../widgets/user_card.dart';

Future<List<String>> followersGetFollowerIds() async {
  String user = await getCurrentUser();
  List<String> list = await userGetFollowers(user);
  if (list.isEmpty) {
    return [''];
  }
  debugPrint(list[0]);
  return list;
}

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: true,
          leading: BackButton(color: Colors.black),
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: Text(
            "Followers",
            style: TextStyle(color: primaryColor),
          ),
        ),
        body: FutureBuilder<List<String>>(
            future: followersGetFollowerIds(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Text("loading...");
                case ConnectionState.done:
                  if (snapshot.data?[0] == '') {
                    return const Text("Follow users");
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (ctx, index) =>
                        UserCard(user_id: snapshot.data![index].toString()),
                  );
                default:
                  return const Text('default?');
              }
            }));
  }
}
