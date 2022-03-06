import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../database/user.dart';
import 'test_profile_page.dart';


/// Enter your test function here ///
void testfunc1() async {
  dynamic user = await ParseUser.currentUser();
  if (user == null) {
    debugPrint("No User Logged In");
  }
  else{
    debugPrint(user["username"]);
  }
}

void testfunc2() async {
  String id = "";

  dynamic user = await ParseUser.currentUser();
  if (user == null){ debugPrint("no user logged in"); return; }

  id = user["objectId"];

  String str = await userGetLastName(id);
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


class testTemplate extends StatelessWidget {
  const testTemplate({Key? key}) : super(key: key);

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
                    onPressed: () =>
                        emailLogin(
                            "eeb24@njit.edu",
                            "password"),
                  ),
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('testfunc1'),
                    onPressed: () => testfunc1(),
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
                    child: const Text('Logout'),
                    onPressed: () => logout(),
                  ),
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('Profile'),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:
                            (context) => testProfile()
                        ),
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
