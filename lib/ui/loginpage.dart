import 'package:flutter/material.dart';
import 'package:newapp/resources/auth_methods.dart';
import 'package:newapp/responsive/mobilescreen_layout.dart';
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
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "success") {
      print(res);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MobileScreenLayout()));
    } else {
      res = 'failure';
      showSnackBAr(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void goToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const loginscreen()));
  }

  void goToSign() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const aspirantGuideSelection()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(212, 0, 0, 0),
      body: SafeArea(
          child: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/backgroundimg.png",
            ),
            opacity: 1010.0,
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          children: [
            Container(
                margin:
                    EdgeInsets.only(top: 0.0, left: 20, right: 20, bottom: 20),
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/taglinelogo.png"),
                        fit: BoxFit.cover))),
            // SizedBox(
            //   height: 64,
            // ),
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
                  textInputType: TextInputType.emailAddress),
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: loginUser,
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
                        "Log in",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: () {
                    goToSign();
                  },
                  child: Container(
                    child: Text(
                      " SIGN UP",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
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
