import 'package:flutter/material.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../database/user.dart';
import '../templates/login_screen.dart';
import 'test_profile_page.dart';
import '../templates/camera_screen.dart';
import 'package:camera/camera.dart';
import '../database/chat.dart';
import '../database/message.dart';
import '../database/post.dart';
import 'package:kandid/main.dart';

/// Enter your test function here ///
void testfunc1(BuildContext context) async {
  chatNew("xv8IPDTc38", await getCurrentUser());
}

void testfunc2(BuildContext context) async {
  String current_id = await getCurrentUser();
  String? chat_id = await chatGetIdWithIds("o6039QCvn9", current_id);
  if (chat_id == null) {
    debugPrint("No chat id found");
    return;
  }
  messageNew(chat_id, "Hello World");
}

void testfunc3(BuildContext context) async {
  debugPrint("Tried Sending Notification");
}

void testfunc4(BuildContext context) async {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => TakePictureScreen()));
  return;
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key, title = "Test Page"}) : super(key: key);

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
                    child: const Text('testfunc2'),
                    onPressed: () => testfunc2(context),
                  ),
                ),
                // Container(
                //   height: 50,
                //   child: TextButton(
                //     child: const Text('testfunc2'),
                //     onPressed: () => testfunc2(context),
                //   ),
                // ),

                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('testfunc3'),
                    onPressed: () => testfunc3(context),
                  ),
                ),
                Container(
                  height: 50,
                  child: TextButton(
                      child: const Text('testfunc4'),
                      onPressed: () => testfunc4(context)),
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('Logout'),
                    onPressed: () => {
                      logout(),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
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
