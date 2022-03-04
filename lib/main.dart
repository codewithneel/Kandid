import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'templates/registration.dart';
import 'templates/login.dart';
import 'templates/my_profile.dart';
import 'my_tests/tester.dart';



/// Here you can set the template you want rendered (don't delete the TestTemplate) ///
//const TEMPLATE = Registration();
const TEMPLATE = TestTemplate();



// format [ <keyApplicationId> , <keyClientId> ]
final _DB_KEYS = ['zV6NcYkI8BZQ6KPHDGvNPQvdnNvfjZ3JUnmIwNJr', 'Us8Z0sIW27BlGAwBVoAWuiXJzKbYBj0AWXxVA0DJ'];

void main() async {


  // Database Connection
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = _DB_KEYS[0];
  final keyClientKey = _DB_KEYS[1];
  final keyParseServerUrl = 'https://parseapi.back4app.com';
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  title: 'Kandid Construct',
  theme: ThemeData(
  primarySwatch: Colors.green,
  ),
  home: TEMPLATE,
  );
  }
}
