import 'package:flutter/material.dart';
import 'package:kandid/database/user.dart';
import 'package:kandid/templates/followers_screen.dart';
import 'package:kandid/templates/my_profile.dart';
import 'package:kandid/templates/other_profile.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/templates/comments_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserCard extends StatefulWidget {
  final user_id;
  const UserCard({Key? key, required this.user_id}) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1648405679817-325c7da58074?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                      ),
                      radius: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    FutureBuilder(
                        future: userGetUsername(widget.user_id),
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

              // Container(
              //   height: 25,
              //   decoration: BoxDecoration(
              //       border: Border.all(width: 1, color: Colors.grey),
              //       borderRadius: BorderRadius.all(Radius.circular(3))),
              //   child: FlatButton(
              //     color: Colors.blue,
              //     child: Text("Follow",
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold, color: Colors.white)),
              //     onPressed: () {},
              //   ),
              // )
            ],
          ),
        ),
        onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OtherProfileScreen(
                        user_id: widget.user_id,
                      )))
            });

    //   padding: const EdgeInsets.symmetric(
    //     vertical: 18,
    //     horizontal: 16,

    //   ),
    //   child: Row(

    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       CircleAvatar(
    //         backgroundImage: NetworkImage(
    //           'https://images.unsplash.com/photo-1648405679817-325c7da58074?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //         ),
    //         radius: 18,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(
    //           left: 16,
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           //mainAxisAlignment: MainAxisAlignment.center,
    //           children: const [
    //             Text('username',
    //                 style: TextStyle(
    //                     color: Colors.black, fontWeight: FontWeight.bold)),
    //             Text('Started Following you',
    //                 style: TextStyle(color: Colors.black)),
    //           ],
    //         ),

    //       ),
    //     ],
    //   ),
    // );
  }
}
