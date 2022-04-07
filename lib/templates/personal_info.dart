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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
  super.dispose();
  _firstNameController.dispose();
  _lastNameController.dispose();
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
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () =>  Navigator.of(context).pop(
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
            children: <Widget> [
              const SizedBox(height: 24),
              Container(
                //padding: const EdgeInsets.symmetric(horizontal: 24),
                child:
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'First Name:',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: _firstNameController,
                hintText: 'Edit your first name', // replace with stored full name from DB
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              Container(
                //padding: const EdgeInsets.symmetric(horizontal: 24),
                child:
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Last Name:',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: _lastNameController,
                hintText: 'Edit your last name', // replace with stored full name from DB
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              Container(
                //padding: const EdgeInsets.symmetric(horizontal: 24),
                child:
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'E-mail address:',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Edit your e-mail address', // replace with stored email from DB
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Phone number:',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: _phoneController,
                hintText: 'Edit your phone number', // replace with stored phone from DB
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Birthday:',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              InputDatePickerFormField(
                fieldLabelText: "",
                //fieldHintText: "Enter your birth date",
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                //initialDate: DateTime.now(),
                onDateSubmitted: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () => trySave(
                  context,
                  _firstNameController.text,
                  _lastNameController.text,
                  _emailController.text,
                  _phoneController.text,
                  selectedDate,
                ),
                child: Container(
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(fontWeight: FontWeight.bold, color: mobileBackgroundColor),
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

  void trySave(BuildContext context, String firstName, String lastName, String email, String phone, DateTime selectedDate) async {
    print('Saved and returned to Settings');
    debugPrint('Full name: $firstName, Last Name: $lastName, Email: $email, Phone: $phone, Birthday: $selectedDate');
    Navigator.of(context).pop(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  } // this function needs to save the entered fields into the DB.

}