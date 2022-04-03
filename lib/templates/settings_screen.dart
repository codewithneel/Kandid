import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kandid/my_tests/tester.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text('Settings', style: TextStyle(color: primaryColor)),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TestTemplate(),
                ),
              );
            },
            child: Icon(Icons.arrow_back_ios_new, color: primaryColor),
          ),
        ),
      body: SafeArea (
        child: ListView(
          children: <Widget>[
            Card(
              child: Material (
                child: InkWell (
                  child: ListTile(
                    leading: const Icon(Icons.account_circle_rounded),
                    title: Text('Edit Profile'),
                  ),
                onTap: () {
                    print('Edit Profile tapped');
                  },
                ),
              ),
            ),
            Card(
              child: Material(
                child: InkWell(
                  child: ListTile(
                    leading: const Icon(Icons.notifications_none),
                    title: Text('Notifications'),
                  ),
                  onTap: () {
                    print('Notifications tapped');
                  }
                ),
              ),
            ),
            Card(
              child: Material(
                child: InkWell(
                  child: ListTile(
                    leading: const Icon(Icons.info_outline_rounded),
                    title: Text('Personal Information'),
                  ),
                  onTap: () {
                    print('Personal Information tapped');
                  }
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}