import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kandid/responsive/mobile_screen_layout.dart';
import 'package:kandid/templates/feed_screen.dart';
import 'package:kandid/templates/my_profile.dart';
import 'package:kandid/templates/personal_info.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:kandid/templates/signup_screen.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:kandid/templates/my_profile.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'my_tests/tester.dart';
import 'package:kandid/templates/login_screen.dart';
import 'package:kandid/templates/camera_screen.dart';
import 'package:kandid/utils/colors.dart';

/// These comments block a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names

/// Here, set the template you want rendered (don't delete the TestTemplate) ///
//const TEMPLATE = LoginScreen();
//const TEMPLATE = PersonalInfo();
const TEMPLATE = TestTemplate();
//const TEMPLATE = SettingsScreen();
//const TEMPLATE = ProfileScreen();

bool isLoggedIn = false;

// format [ <keyApplicationId> , <keyClientId> ]
final _DB_KEYS = [
  'zV6NcYkI8BZQ6KPHDGvNPQvdnNvfjZ3JUnmIwNJr',
  'Us8Z0sIW27BlGAwBVoAWuiXJzKbYBj0AWXxVA0DJ'
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Database Connection
  final keyApplicationId = _DB_KEYS[0];
  final keyClientKey = _DB_KEYS[1];
  const keyParseServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kandid',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: TEMPLATE,
    );
  }
}
