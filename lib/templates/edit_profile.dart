import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kandid/my_tests/tester.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/alerts.dart';
import 'package:kandid/my_tests/test_profile_page.dart';
import 'package:kandid/templates/signup_screen.dart';
import 'package:kandid/widgets/text_field_input.dart';
import '../database/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
  super.dispose();
  _fullNameController.dispose();
  _userNameController.dispose();
  _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text('Edit Profile', style: TextStyle(color: primaryColor)),
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () => trySave(
              context,
              _fullNameController.text,
              _userNameController.text,
              _bioController.text,
            ),
            child: Icon(Icons.arrow_back_ios_new, color: primaryColor),
          ),
        ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              const SizedBox(height: 24),
              const CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1646112918482-2763d6e12320?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
                ),
                radius: 40,
              ),
              const SizedBox(height: 24),
              Container(
                //padding: const EdgeInsets.symmetric(horizontal: 24),
                child:
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Full Name:',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: _fullNameController,
                hintText: 'Edit your name', // replace with stored full name from DB
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              Container(
                //padding: const EdgeInsets.symmetric(horizontal: 24),
                child:
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'User Name:',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: _userNameController,
                hintText: 'Edit your username', // replace with stored email from DB
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              Container(
                //padding: const EdgeInsets.symmetric(horizontal: 24),
                child:
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bio:',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Edit your bio', // replace with stored phone from DB
                textInputType: TextInputType.multiline,
              ),
              const SizedBox(height: 24),
          ],
        ),
      ),
    ),
    );
  }

  void trySave(BuildContext context, String fullName, String username, String bio,) async {
    print('Saved and returned to Settings');
    print('Full name: ${fullName} Email: ${username}, Phone: ${bio}');
    Navigator.of(context).pop(
        MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        ),
    );
  } // this function needs to save the entered fields into the DB.

}