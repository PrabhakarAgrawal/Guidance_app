import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProviderUSer with ChangeNotifier(
  
  User? _user;
  User get getUser => _user


)