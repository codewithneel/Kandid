import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'templates/registration.dart';
import 'templates/login.dart';


bool debug = false;


// format [ <keyApplicationId> , <keyClientId> ]
final _DB_KEYS = ['H0TQYPBtcCqOL9NLbfJoQRmrbie4hLwbLzHv5oF8', 'qUlu6Qcxl4cmx535TFyIrQqHMnhplrro1vFynCu9'];

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
  home: const Login(),
  );
  }
}
