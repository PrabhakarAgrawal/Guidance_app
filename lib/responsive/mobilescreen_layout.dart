import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp/utils/globalvar.dart';

class MobileScreenLayout extends StatefulWidget {
  MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
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
                icon: Icon(Icons.add_circle_outline,
                    color: _page == 1
                        ? Colors.white
                        : Color.fromARGB(255, 197, 194, 194),
                    size: 30.0),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,
                    color: _page == 2
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
