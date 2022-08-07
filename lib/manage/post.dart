import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String additionalText;
  final String uid;
  final String postId;
  final String username;
  final date;
  final String college;
  final String person;
  final String postUrl;
  final String profilePic;
  final likes;

  Post(
      {required this.username,
      required this.uid,
      required this.postUrl,
      required this.profilePic,
      required this.date,
      required this.person,
      required this.additionalText,
      required this.likes,
      required this.postId,
      required this.college});
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "additionalText": additionalText,
        "postUrl": postUrl,
        "date": date,
        "college": college,
        "person": person,
        "postId": postId,
        "profilePic": profilePic,
        "likes": likes,
      };
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        additionalText: snapshot["addtionalText"],
        uid: snapshot["uid"],
        likes: snapshot["likes"],
        postId: snapshot["postId"],
        date: snapshot["date"],
        college: snapshot["college"],
        person: snapshot["person"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        profilePic: snapshot['profilePic']);
  }
}
