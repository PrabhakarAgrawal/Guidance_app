import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';
import '../widgets/text_field_input.dart';

class guideSignup extends StatefulWidget {
  const guideSignup({Key? key}) : super(key: key);

  @override
  State<guideSignup> createState() => _guideSignupState();
}

class _guideSignupState extends State<guideSignup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    _collegeController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 64,
            ),
            TextFieldInput(
                hintText: 'Enter Your Username',
                isPass: false,
                textEditingController: _usernameController,
                textInputType: TextInputType.text),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
                hintText: 'Enter Your Email',
                isPass: false,
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
                hintText: 'Enter Your Password',
                isPass: true,
                textEditingController: _passwordController,
                textInputType: TextInputType.text),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
                hintText: 'Enter Name Of Your College',
                isPass: false,
                textEditingController: _collegeController,
                textInputType: TextInputType.text),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
                hintText: 'Enter Your bio',
                isPass: false,
                textEditingController: _bioController,
                textInputType: TextInputType.text),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () async {
                String res = await secondAuthMethods().signUpGuide(
                    email: _emailController.text,
                    password: _passwordController.text,
                    username: _usernameController.text,
                    college: _collegeController.text,
                    bio: _bioController.text);
                print(res);
              },
              child: Container(
                child: Text("Sign up"),
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      )),
    );
  }
}