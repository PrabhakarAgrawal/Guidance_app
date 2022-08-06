import 'package:flutter/material.dart';
import 'package:newapp/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {Key? key,
      required this.mobileScreenLayout,
      required this.webScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // webscreen
        return webScreenLayout;
      } else {
        return mobileScreenLayout;
      }
      // mobile screen
    }));
  }
}
