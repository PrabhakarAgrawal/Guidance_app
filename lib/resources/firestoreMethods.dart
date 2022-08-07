import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/manage/post.dart';
import 'package:newapp/resources/storage.dart';
import 'package:uuid/uuid.dart';

class firestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String username,
    String uid,
    String profilePic,
    String additionalText,
    String college,
    String person,
    Uint8List file,
  ) async {
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
      college = (snap.data() as Map<String, dynamic>)["college"];

      person = "Guide";
    } else {
      college = "";
      person = "Aspirant";
    }
    String res = 'some error occured';
    try {
      String photoUrl = await StorageMeth().upload_Img("posts", file, true);
      String postId = const Uuid().v1();
      Post post = Post(
          username: username,
          uid: uid,
          postUrl: photoUrl,
          college: college,
          person: person,
          profilePic: profilePic,
          date: DateTime.now(),
          additionalText: additionalText,
          likes: [],
          postId: postId);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
