import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kandid/widgets/alerts.dart';
import 'package:kandid/my_tests/test_profile_page.dart';
import 'package:kandid/templates/signup_screen.dart';
import 'package:kandid/utils/colors.dart';
import 'package:kandid/widgets/text_field_input.dart';
import '../database/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 1),
              SvgPicture.asset(
                'assets/kandidLogo.svg',
                color: primaryColor,
                height: 64,
              ),
              //title
              const SizedBox(height: 64),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'enter your password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () => {
                  tryLogin(
                      context,
                      _emailController.text,
                      _passwordController.text
                  ),
                },
                child: Container(
                  child: const Text(
                    "Log in",
                    style: TextStyle(color: mobileBackgroundColor),
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
              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container(), flex: 1),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account? "),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    ),
                    child: Container(
                      //to make it clickable
                      child: const Text(
                        "Sign Up",
                        style: TextStyle( fontWeight: FontWeight.bold ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                  )
                ],
              )

              //text for email
              //text for password
              //button for login
              //transition to sign up
            ],
          ),
        ),
      ),
    );
  }
}


void tryLogin(BuildContext context,String email, String password) async{

  if (await emailLogin(email, password)){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const testProfile(),
      ),
    );
  }
  else{
    showError(context,
        "Something went wrong\n"
        "Please fill all fields\n"
            "and check for typos");
  }

}
