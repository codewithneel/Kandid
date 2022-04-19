import 'package:flutter/material.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../database/user.dart';
import '../templates/login_screen.dart';
import '../templates/my_profile.dart';
import 'notification_api.dart';
import 'test_profile_page.dart';
import '../templates/camera_screen.dart';
import 'package:camera/camera.dart';
import '../database/chat.dart';
import '../database/message.dart';
import '../database/post.dart';
import 'package:kandid/main.dart';

class NotificationTestPage extends StatefulWidget {
  @override
  State<NotificationTestPage> createState() => _NotificationTest();
}

class _NotificationTest extends State<NotificationTestPage> {
  @override
  void initState() {
    super.initState();

    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => TakePictureScreen()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text(
            'Notification Tester',
            style: TextStyle(color: primaryColor),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                    child: const Text(
                      'Send Push Notification',
                      style: TextStyle(color: greenColor),
                    ),
                    onPressed: () => {
                          NotificationApi.showNotification(
                            title: "Make a New Post",
                            body: "You have 30 minutes to create a new post.",
                            payload: "my payload",
                          ),
                          debugPrint("Tried Sending Notification")
                        }),
              ),
            ],
          ),
        ));
  }
}
