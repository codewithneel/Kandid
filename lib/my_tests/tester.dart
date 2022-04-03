
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../database/user.dart';
import 'test_profile_page.dart';
import '../templates/camera_screen.dart';
import 'package:camera/camera.dart';
import '../database/chat.dart';
import '../database/message.dart';
import '../database/post.dart';

/// Enter your test function here ///
void testfunc1(BuildContext context) async {
   chatNew("xv8IPDTc38", await getCurrentUser());
}

void testfunc2() async {
  String current_id = await getCurrentUser();
  String? chat_id = await chatGetIdWithIds("xv8IPDTc38", current_id);
  if(chat_id == null) { debugPrint("No chat id found"); return; }
  messageNew(current_id, chat_id, "Hello World");
}

void testfunc3(BuildContext context) async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  //WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TakePictureScreen(camera: firstCamera),
    ),
  );
}

void testfunc4() async {
  String id = "";

  dynamic user = await ParseUser.currentUser();
  if (user == null) {
    debugPrint("no user logged in");
    return;
  }

  id = user["objectId"];

  String? str = await userGetLastName(id);
  debugPrint(str);
  userSetLastName("miller");
  str = await userGetLastName(id);
  debugPrint(str);

  // newUser(
  //     context,
  //     "edelb",
  //     "eeb24@njit.edu",
  //     "password",
  //     "tom",
  //     "smith",
  //     DateTime.now(),
  //     true),
}


class TestTemplate extends StatelessWidget {
  const TestTemplate({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tester",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const TestPage(title: 'Test Page'),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final controllerUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Kandid Tester'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextField(
                  controller: controllerUsername,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'test text'),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('Login'),
                    onPressed: () => emailLogin("eeb24@njit.edu", "password"),
                  ),
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('testfunc1'),
                    onPressed: () => testfunc1(context),
                  ),
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('testfunc2'),
                    onPressed: () => testfunc2(),
                  ),
                ),
                Container(
                  height: 50,
                  child: TextButton(
                      child: const Text('View Post'), onPressed: () => {}),
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('Profile'),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => testProfile()),
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
