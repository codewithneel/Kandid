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

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  @override
  void dispose() {
  super.dispose();
  _fullNameController.dispose();
  _emailController.dispose();
  _phoneController.dispose();
  _birthdayController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text('Personal Information', style: TextStyle(color: primaryColor)),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            child: Icon(Icons.arrow_back_ios_new, color: primaryColor),
          ),
          actions: <Widget> [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => trySave(
                    context,
                    _fullNameController.text,
                    _emailController.text,
                    _phoneController.text,
                    _birthdayController.text,
                  ),
                child: Icon(Icons.save_outlined, color: primaryColor),
              ),
            ),
          ],
        ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              TextFieldInput(
                textEditingController: _fullNameController,
                hintText: 'Edit your name', // replace with stored full name from DB
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Edit your e-mail address', // replace with stored email from DB
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _phoneController,
                hintText: 'Edit your phone number', // replace with stored phone from DB
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _birthdayController,
                hintText: 'Edit your birthday', // replace with birthdate from DB
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
          ],
        ),
      ),
    ),
    );
  }

  void trySave(BuildContext context, String fullName, String email, String phone, String birthdate) async {
    print('Clicked save');
  } // this function needs to save the entered fields into the DB.

}