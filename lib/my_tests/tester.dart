import 'package:flutter/material.dart';

import '../database/user.dart';


/// Enter your test function here ///
const test_func = {};


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
                    child: const Text('Action Button'),
                    onPressed: () => newUser(context, "usernamesssss", "email@emailsssss.com", "password", "fname", "lname", DateTime.now(), true),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}