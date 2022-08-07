import 'package:flutter/material.dart';
import 'package:newapp/ui/aspirant_signup_page.dart';
import 'package:newapp/ui/guide_signup_page.dart';

import 'loginpage.dart';

class aspirantGuideSelection extends StatelessWidget {
  const aspirantGuideSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 139, 64, 251),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => loginscreen(),
                  ));
                },
                icon: Icon(Icons.arrow_back)),
            title: const Text('Select'),
            centerTitle: false,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => aspirantSignup()));
                }),
                child: Container(
                  child: Text("Aspirant"),
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
              InkWell(
                onTap: (() {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => guideSignup()));
                }),
                child: Container(
                  child: Text("Guide"),
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
