import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newapp/resources/getdetails.dart';
import 'package:newapp/responsive/commentscreen.dart';
import 'package:newapp/utils/utils.dart';

import '../resources/firestoreMethods.dart';

class photoPosting extends StatefulWidget {
  final snap;
  const photoPosting({Key? key, required this.snap}) : super(key: key);

  @override
  State<photoPosting> createState() => _photoPostingState();
}

class _photoPostingState extends State<photoPosting> {
  String uid = '';

  int commentcount = 0;

  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
    commentCounter();
  }

  void commentCounter() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentcount = snap.docs.length;
    } catch (err) {
      showSnackBAr(
        err.toString(),
        context,
      );
    }
    setState(() {});
  }

  Future<dynamic> getdetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      uid = (snap.data() as Map<String, dynamic>)["uid"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: EdgeInsets.only(top: 12, left: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat.yMMMd().format(widget.snap['date'].toDate()),
              style: TextStyle(
                color: Color.fromARGB(255, 151, 150, 150),
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(255, 101, 101, 101),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundImage: NetworkImage(widget.snap['profilePic']),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.snap['username'],
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(widget.snap['college'],
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Color.fromARGB(255, 218, 216, 216)))
                          ],
                        ),
                        Text('~ ${widget.snap['person']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color.fromARGB(255, 102, 158, 255)))
                      ],
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                    child: ListView(
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  children: ['Report']
                                      .map((e) => InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 13, horizontal: 17),
                                              child: Text(e),
                                            ),
                                          ))
                                      .toList(),
                                )));
                      },
                      icon: Icon(Icons.more_vert_rounded),
                      color: Colors.white)
                ],
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(7),
                child: RichText(
                    text: TextSpan(
                        text: widget.snap['additionalText'],
                        style: TextStyle(color: Colors.white, fontSize: 12))),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.37,
                width: double.infinity,
                child: Image.network(
                  widget.snap['postUrl'],
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        await firestoreMethods().likePost(
                            widget.snap['postId'], uid, widget.snap['likes']);
                        // print(
                        //   getDetails().getdetails("uid"),
                        // );
                      },
                      icon: Icon(Icons.thumb_up_alt_rounded,
                          color: widget.snap['likes'].contains(uid)
                              ? Color.fromARGB(255, 139, 64, 251)
                              : Colors.white)),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => commentScreen(
                                  snap: widget.snap,
                                )));
                      },
                      icon: Icon(Icons.question_answer_rounded,
                          color: Colors.white)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.send_rounded, color: Colors.white)),
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.download)),
                  ))
                ],
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: Text('${widget.snap['likes'].length}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text('$commentcount',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
