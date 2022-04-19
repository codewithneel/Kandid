import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kandid/my_tests/tester.dart';
import 'package:kandid/templates/personal_info.dart';
import 'package:kandid/templates/notifications.dart';
import 'package:kandid/templates/my_profile.dart';
import 'package:kandid/templates/edit_profile.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/alerts.dart';
import 'package:kandid/my_tests/test_profile_page.dart';
import 'package:kandid/templates/signup_screen.dart';
import 'package:kandid/widgets/text_field_input.dart';
import '../database/user.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   _emailController.dispose();
  //   _passwordController.dispose();
  // }

  void _navigatetoPersonalInformation(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PersonalInfo()));
  }

  void _navigatetoNotificationsSettings(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NotificationsSettings()));
  }

  void _navigatetoEditProfile(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EditProfile()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Settings', style: TextStyle(color: primaryColor)),
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
          },
          child: const Icon(Icons.arrow_back_ios_new, color: primaryColor),
        ),
      ),
      body: SafeArea(
        child: ListView(children: <Widget>[
          Card(
            child: Material(
              child: InkWell(
                child: const ListTile(
                  tileColor: Colors.white,
                  leading:
                      Icon(Icons.account_circle_rounded, color: Colors.black),
                  title: Text('Edit Profile'),
                ),
                onTap: () {
                  _navigatetoEditProfile(context);
                  debugPrint('Edit Profile tapped');
                },
              ),
            ),
          ),
          Card(
            child: Material(
              child: InkWell(
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading:
                        Icon(Icons.notifications_none, color: Colors.black),
                    title: Text('Notifications'),
                  ),
                  onTap: () {
                    _navigatetoNotificationsSettings(context);
                    debugPrint('Notifications tapped');
                  }),
            ),
          ),
          Card(
            child: Material(
              child: InkWell(
                  child: const ListTile(
                    tileColor: Colors.white,
                    leading:
                        Icon(Icons.info_outline_rounded, color: Colors.black),
                    title: Text('Personal Information'),
                  ),
                  onTap: () {
                    _navigatetoPersonalInformation(context);
                    debugPrint('Personal Information tapped');
                  }),
            ),
          )
        ]),
      ),
    );
  }
}
