import 'package:flutter/material.dart';
import 'package:newapp/resources/auth_methods.dart';
import 'package:newapp/ui/aspirant_guide_selection.dart';
import 'package:newapp/ui/aspirant_signup_page.dart';
import 'package:newapp/ui/signuppage.dart';
import 'package:newapp/widgets/text_field_input.dart';
import 'package:newapp/utils/utils.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    // setState(() {
    //   _isLoading = true;
    // });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    
    if (res == "success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const aspirantSignup()));
    } else {
      showSnackBAr(res, context);
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }

  void goToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const loginscreen()));
  }

  void goToSign() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const aspirantGuideSelection()));
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
                textInputType: TextInputType.emailAddress),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: loginUser,
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
                    : const Text("Log in"),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Don't have an account?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: () {
                    goToSign();
                  },
                  child: Container(
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
