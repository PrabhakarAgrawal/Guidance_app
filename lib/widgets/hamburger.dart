import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/resources/auth_methods.dart';
import 'package:newapp/ui/loginpage.dart';
// import 'package:flutter';

class Hamburger extends StatefulWidget {
  const Hamburger({Key? key}) : super(key: key);

  @override
  State<Hamburger> createState() => _HamburgerState();
}

class _HamburgerState extends State<Hamburger> {
  String username = '';

  String person = '';

  String profilePic = '';

  String bio = '';

  String uid = '';

  String college = '';

  List followers = [];

  int postlength = 0;

  String postfileurl = '';

  bool isload = false;

  String type = 'photoposts';
  String email = '';

  @override
  void initState() {
    super.initState();
    getdetails();
  }

  Future<dynamic> getdetails() async {
    setState(() {
      isload = true;
    });
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)["username"];
      email = (snap.data() as Map<String, dynamic>)["email"];

      profilePic = (snap.data() as Map<String, dynamic>)["profilePic"];
      isload = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      child: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: Colors.grey,
                child: UserAccountsDrawerHeader(
                  accountName: Text(username),
                  accountEmail: Text(email),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        profilePic,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
              Container(
                color: Colors.black,
                child: ListTile(
                  leading: TextButton(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: null,
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                child: ListTile(
                  leading: TextButton(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: null,
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                child: ListTile(
                  leading: TextButton(
                    child: Text(
                      'Study Material',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: null,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await AuthMethods().signout();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => loginscreen()));
                },
                child: Container(
                  color: Colors.black,
                  child: ListTile(
                    leading: TextButton(
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: null,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
