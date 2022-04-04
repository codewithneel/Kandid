import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kandid/my_tests/tester.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/alerts.dart';
import 'package:kandid/my_tests/test_profile_page.dart';
import 'package:kandid/templates/signup_screen.dart';
import 'package:kandid/widgets/text_field_input.dart';
import '../database/user.dart';

class NotificationsSettings extends StatefulWidget {
  const NotificationsSettings({Key? key}) : super(key: key);

  @override
  _NotificationsSettingsState createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends State<NotificationsSettings> {
  bool PostReminders = false;
  bool LikesSwitch = false;
  bool CommentsSwitch = false;
  bool MessagesSwitch = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Notifications', style: TextStyle(color: primaryColor)),
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => trySave(context, PostReminders, LikesSwitch, CommentsSwitch, MessagesSwitch),
          child: Icon(Icons.arrow_back_ios_new, color: primaryColor),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              const SizedBox(height: 24),
              SwitchListTile.adaptive(
                title: Text('Post Reminders'),
                subtitle: Text('Get reminders to make new posts.'),
                value: PostReminders,
                onChanged: (bool value) {
                setState(() {
                  PostReminders = value;
                });
                }
              ),
              const SizedBox(height: 24),
              SwitchListTile.adaptive(
                title: Text('Likes'),
                subtitle: Text('Get a notification when someone likes your posts.'),
                value: LikesSwitch,
                onChanged: (bool value) {
                setState(() {
                  LikesSwitch = value;
                });
                }
              ),
              const SizedBox(height: 24),
              SwitchListTile.adaptive(
                  title: Text('Comments'),
                  subtitle: Text('Get a notification when someone comments on your posts.'),
                  value: CommentsSwitch,
                  onChanged: (bool value) {
                    setState(() {
                      CommentsSwitch = value;
                    });
                  }
              ),
              const SizedBox(height: 24),
              SwitchListTile.adaptive(
                  title: Text('Messages'),
                  subtitle: Text('Get a notification when someone sends you a direct message.'),
                  value: MessagesSwitch,
                  onChanged: (bool value) {
                    setState(() {
                      MessagesSwitch = value;
                    });
                  }
              ),
            ],
          ),
        ),
    ),
    );
  }

  void trySave(BuildContext context, bool reminders, bool likes, bool comments, bool messages) async {
    print('Saved and returned to Settings');
    print('Post Reminders: ${reminders}, Likes: ${likes}, Comments: ${comments}, DMs: ${messages}');
    Navigator.of(context).pop(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  } // this function needs to save the entered fields into the DB.

}