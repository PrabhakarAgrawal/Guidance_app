import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/ui/contentpage.dart';
import 'package:newapp/ui/postscreen.dart';
import 'package:newapp/ui/profile_screen.dart';

var homeScreenItems = [
  contentPage(),
  Text('search'),
  AddPost(),
  Profile(uid: FirebaseAuth.instance.currentUser!.uid),
];
