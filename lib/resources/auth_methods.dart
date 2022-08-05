import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/resources/storage.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign up user
  Future<String> signUpAspirant({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          password.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        String photURL =
            await StorageMeth().upload_Img("ProfilePics", file, false);
        //add user to database
        await _firestore
            .collection('aspirant')
            .doc('aspirant')
            .collection('users')
            .doc(cred.user!.uid)
            .set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          "photoURL": photURL,
        });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //register user
         await _auth.signInWithEmailAndPassword(
            email: email, password: password);


        //add user to database
        res = "success";
      } else {
        res = ("Please enter all the fields");
      }
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //   } else if (e.code == "weak-password") {
    //     res = "Password should be atleast 6 letters";
    //   } else if (e.code == "invalid-email") {
    //     res = "Email Not Found";
    //   }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

class secondAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign up user
  Future<String> signUpGuide({
    required String email,
    required String password,
    required String username,
    required String college,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          password.isNotEmpty ||
          college.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        String photURL =
            await StorageMeth().upload_Img("ProfilePics", file, false);
        //add user to database
        await _firestore
            .collection('guide')
            .doc('guide')
            .collection('users')
            .doc(cred.user!.uid)
            .set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'college': college,
          'bio': bio,
          'followers': [],
          'following': [],
          "photoURL": photURL
        });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Future<String> loginUser({
  //   required String email,
  //   required String password,
  // }) async {
  //   String res = "Some error occured";
  //   try {
  //     if (email.isNotEmpty || password.isNotEmpty) {
  //       //register user
  //       UserCredential cred = await _auth.signInWithEmailAndPassword(
  //           email: email, password: password);
  //       //   print(cred.user!.uid);
  //       //   //add user to database
  //       //  await _firestore.collection('users').doc(cred.user!.uid).set({

  //       //     'uid': cred.user!.uid,
  //       //     'email': email,

  //       //     'followers': [],
  //       //     'following': [],
  //       //   });
  //       res = "success";
  //     } else {
  //       res=("Please enter all the fields");
  //     }
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   return res;
  // }
}
