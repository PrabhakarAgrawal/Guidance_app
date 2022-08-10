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
          backgroundColor: Color.fromARGB(212, 0, 0, 0),
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
          body: Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/backgroundimg.png",
                ),
                opacity: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                            image: AssetImage('assets\images\aspirant.png'),
                            fit: BoxFit.cover))),

                InkWell(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => aspirantSignup()));
                  }),
                  child: Container(
                    child: Text(
                      "Aspirant",
                      style:
                          TextStyle(color: Color.fromARGB(255, 246, 233, 233)),
                    ),
                    height: 40,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple[400]),
                  ),
                ),

                // ],

                SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: (() {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => guideSignup()));
                  }),
                  child: Container(
                    child: Text(
                      "Guide",
                      style:
                          TextStyle(color: Color.fromARGB(255, 246, 233, 233)),
                    ),
                    height: 40,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple[400]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
