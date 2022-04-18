import 'package:flutter/material.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/text_field_input.dart';
import '../database/user.dart';
import '../templates/my_profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title:
            const Text('Edit Profile', style: TextStyle(color: primaryColor)),
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(
            MaterialPageRoute(
              builder: (context) => const SettingsScreen(),
            ),
          ),
          child: const Icon(Icons.arrow_back_ios_new, color: primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 24),
              const CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1646112918482-2763d6e12320?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
                ),
                radius: 40,
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'User Name:',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                  future: myProfileGetUsername(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return TextFieldInput(
                          textEditingController: _userNameController,
                          hintText:
                              "loading...", // replace with stored phone from DB
                          textInputType: TextInputType.multiline,
                        );
                      case ConnectionState.done:
                        return TextFieldInput(
                          textEditingController: _userNameController,
                          hintText: snapshot.data
                              .toString(), // replace with stored phone from DB
                          textInputType: TextInputType.multiline,
                        );
                      default:
                        return TextFieldInput(
                          textEditingController: _userNameController,
                          hintText:
                              "Default??", // replace with stored phone from DB
                          textInputType: TextInputType.multiline,
                        );
                    }
                  }),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Bio:',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                  future: myProfileGetBio(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return TextFieldInput(
                          textEditingController: _bioController,
                          hintText:
                              "loading...", // replace with stored phone from DB
                          textInputType: TextInputType.multiline,
                        );
                      case ConnectionState.done:
                        return TextFieldInput(
                          textEditingController: _bioController,
                          hintText: snapshot.data
                              .toString(), // replace with stored phone from DB
                          textInputType: TextInputType.multiline,
                        );
                      default:
                        return TextFieldInput(
                          textEditingController: _bioController,
                          hintText:
                              "Default??", // replace with stored phone from DB
                          textInputType: TextInputType.multiline,
                        );
                    }
                  }),
              const SizedBox(height: 24),
              InkWell(
                onTap: () => trySave(
                  context,
                  _userNameController.text,
                  _bioController.text,
                ),
                child: Container(
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mobileBackgroundColor),
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: greenColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void trySave(
    BuildContext context,
    String username,
    String bio,
  ) async {
    debugPrint('Saved and returned to Settings');
    debugPrint('Username: $username, Bio: $bio');

    if (username != "") {
      userSetUsername(username);
    }
    if (bio != "") {
      userSetBio(bio);
    }

    Navigator.of(context).pop(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  } // this function needs to save the entered fields into the DB.
}
