import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/utils/utils.dart';

import '../resources/auth_methods.dart';
import '../widgets/text_field_input.dart';

class aspirantSignup extends StatefulWidget {
  const aspirantSignup({Key? key}) : super(key: key);

  @override
  State<aspirantSignup> createState() => _aspirantSignupState();
}

class _aspirantSignupState extends State<aspirantSignup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectPic() async {
    Uint8List im = await pickPhoto(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpAspirant() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpAspirant(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    print(res);
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnackBAr(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 64,
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg"),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectPic,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
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
                hintText: 'Enter Your bio',
                isPass: false,
                textEditingController: _bioController,
                textInputType: TextInputType.text),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: signUpAspirant,
              child: Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text("Sign Up"),
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
