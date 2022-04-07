import 'package:flutter/material.dart';
import 'package:kandid/templates/settings_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/text_field_input.dart';
import '../database/user.dart';

/// This comment blocks a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names

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
              FutureBuilder(
                  future: personalInfoGetFirstName(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return TextFieldInput(
                          textEditingController: _firstNameController,
                          hintText: 'loading first name...', // replace with stored full name from DB
                          textInputType: TextInputType.text,
                        );
                      case ConnectionState.done:
                        return TextFieldInput(
                          textEditingController: _firstNameController,
                          hintText: snapshot.data.toString(), // replace with stored full name from DB
                          textInputType: TextInputType.text,
                        );
                      default:
                        return TextFieldInput(
                          textEditingController: _firstNameController,
                          hintText: 'Default??', // replace with stored full name from DB
                          textInputType: TextInputType.text,
                        );
                    }
                  }),

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
              FutureBuilder(
                  future: personalInfoGetLastName(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return TextFieldInput(
                          textEditingController: _lastNameController,
                          hintText: "loading last name...", // replace with stored full name from DB
                          textInputType: TextInputType.text,
                        );
                      case ConnectionState.done:
                        return TextFieldInput(
                          textEditingController: _lastNameController,
                          hintText: snapshot.data.toString(), // replace with stored full name from DB
                          textInputType: TextInputType.text,
                        );
                      default:
                        return TextFieldInput(
                          textEditingController: _lastNameController,
                          hintText: 'Default??', // replace with stored full name from DB
                          textInputType: TextInputType.text,
                        );
                    }
                  }),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'E-mail address:',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                  future: personalInfoGetEmail(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return TextFieldInput(
                          textEditingController: _emailController,
                          hintText: 'loading...', // replace with stored email from DB
                          textInputType: TextInputType.text,
                        );
                      case ConnectionState.done:
                        return TextFieldInput(
                          textEditingController: _emailController,
                          hintText: snapshot.data.toString(), // replace with stored email from DB
                          textInputType: TextInputType.text,
                        );
                      default:
                        return TextFieldInput(
                          textEditingController: _emailController,
                          hintText: 'Default??', // replace with stored email from DB
                          textInputType: TextInputType.text,
                        );
                    }
                  }),


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

  void trySave(BuildContext context, String first_name, String last_name, String email, String phone, DateTime selected_date) async {
    debugPrint('Saved and returned to Settings');
    debugPrint('Full name: $first_name, Last Name: $last_name, Email: $email, Phone: $phone, Birthday: $selected_date');

    if(first_name != ""){ userSetFirstName(first_name); }
    if(last_name  != ""){ userSetLastName(last_name); }
    if(email      != ""){ userSetEmail(email); }

    Navigator.of(context).pop(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  } // this function needs to save the entered fields into the DB.
}

Future<String> personalInfoGetFirstName() async {
  String user_id = await getCurrentUser();
  dynamic ret = await userGetFirstName(user_id);
  if (ret == null || ret == "") {
    return "<No First Name>";
  }
  return ret;
}

Future<String> personalInfoGetLastName() async {
  String user_id = await getCurrentUser();
  dynamic ret = await userGetLastName(user_id);
  if (ret == null || ret == "") {
    return "<No Last Name>";
  }
  return ret;
}

Future<String> personalInfoGetEmail() async {
  String user_id = await getCurrentUser();
  dynamic ret = await userGetEmail(user_id);
  if (ret != null) {
    return ret;
  }
  return "<No Email>";
}

