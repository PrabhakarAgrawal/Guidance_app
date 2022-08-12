import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/utils/utils.dart';

import '../resources/auth_methods.dart';
import '../responsive/mobilescreen_layout.dart';
import '../widgets/text_field_input.dart';
import 'aspirant_guide_selection.dart';

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
  String person = 'Aspirant';
  String college = '';
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
        file: _image!,
        person: person,
        college: college);
    print(res);
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnackBAr(res, context);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MobileScreenLayout(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => aspirantGuideSelection(),
              ));
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text(
          'Sign up',
          style: TextStyle(fontFamily: 'ananias'),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
          child: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(horizontal: 32),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/backgroundimg.png",
            ),
            opacity: 210.0,
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextFieldInput(
                    hintText: 'Enter Your Username',
                    isPass: false,
                    textEditingController: _usernameController,
                    textInputType: TextInputType.text),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextFieldInput(
                    hintText: 'Enter Your Email',
                    isPass: false,
                    textEditingController: _emailController,
                    textInputType: TextInputType.emailAddress),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextFieldInput(
                    hintText: 'Enter Your Password',
                    isPass: true,
                    textEditingController: _passwordController,
                    textInputType: TextInputType.text),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextFieldInput(
                    hintText: 'Enter Your bio',
                    isPass: false,
                    textEditingController: _bioController,
                    textInputType: TextInputType.text),
              ),
              SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: signUpAspirant,
                child: Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.purple[400]),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Color.fromARGB(255, 231, 230, 230),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
