import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp/providers/providerUser.dart';
import 'package:newapp/utils/globalvar.dart';
import 'package:newapp/manage/forAspirant.dart' as manage1;
import 'package:newapp/manage/forGuide.dart' as manage2;
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String name = "";
  int type = 0;
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
    getName();
  }

  Future<DocumentSnapshot> getName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('aspirant')
        .doc('aspirant')
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (snap.data() == null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('guide')
          .doc('guide')
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      print(snap.data());
      print("guide");
      return snap;
    } else {
      print("aspirant");
      print(snap.data());
      return snap;
    }
    setState(() {
      name = (snap.data() as Map<String, dynamic>)["username"];
    });
    print("$name");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          children: homeScreenItems,
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                    color: _page == 0
                        ? Colors.white
                        : Color.fromARGB(255, 197, 194, 194),
                    size: 30.0),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded,
                    color: _page == 1
                        ? Colors.white
                        : Color.fromARGB(255, 197, 194, 194),
                    size: 30.0),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline,
                    color: _page == 2
                        ? Colors.white
                        : Color.fromARGB(255, 197, 194, 194),
                    size: 30.0),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,
                    color: _page == 3
                        ? Colors.white
                        : Color.fromARGB(255, 197, 194, 194),
                    size: 30.0),
                label: ''),
          ],
          backgroundColor: Color.fromARGB(255, 139, 64, 251),
          onTap: navigationTapped,
        ),
      ),
    );
  }
}
