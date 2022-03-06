import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../database/user.dart';
import '../templates/login_screen.dart';
import 'tester.dart';

/// Enter your test function here ///
void funcReturn() async {
  ParseUser user = await ParseUser.currentUser();

  if (user["username"] == null) {
    debugPrint("No User Logged In");
  }
  else{
    debugPrint(user["username"]);
  }
}

Future<String> displayUsername() async{
  try {
    String user_id = await getCurrentUser();
    return await userGetUsername(user_id);
  }
  catch(e){
    return "No User";
  }

}

class testProfile extends StatelessWidget {
  const testProfile({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tester",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const TestProfilePage(title: 'Test Page'),
    );
  }
}

class TestProfilePage extends StatefulWidget {
  const TestProfilePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TestProfilePage> createState() => _TestProfilePageState();
}

class _TestProfilePageState extends State<TestProfilePage> {
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
                FutureBuilder(
                    future: displayUsername(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState){
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return const Text('Loading...');
                        case ConnectionState.done:
                          return Text(snapshot.data.toString());
                        default:
                          return const Text('default?');
                      }
                    }
                ),
                TextField(),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('Return'),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:
                            (context) => const LoginScreen()
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
