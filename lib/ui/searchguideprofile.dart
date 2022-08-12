import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newapp/resources/firestoreMethods.dart';
import 'package:video_player/video_player.dart';

class searchGuideProfile extends StatefulWidget {
  final String uid;
  const searchGuideProfile({Key? key, required this.uid}) : super(key: key);

  @override
  State<searchGuideProfile> createState() => _searchGuideProfileState();
}

class _searchGuideProfileState extends State<searchGuideProfile> {
  String username = '';
  String person = '';
  String profilePic = '';
  String bio = '';
  String college = '';
  List followers = [];
  int postlength = 0;
  String postfileurl = '';
  bool isload = false;
  String type = 'photoposts';
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    getdetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController?.dispose();
  }

  void buttonpressed() {
    if (_videoPlayerController != null) {
      setState(() {
        _videoPlayerController!.value.isPlaying
            ? _videoPlayerController!.pause()
            : _videoPlayerController!.play();
      });
    }
  }

  Future<dynamic> getdetails() async {
    setState(() {
      isload = true;
    });
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(widget.uid)
        .get();
    var postsnap = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: widget.uid)
        .get();

    setState(() {
      postlength = postsnap.docs.length;

      username = (snap.data() as Map<String, dynamic>)["username"];
      person = (snap.data() as Map<String, dynamic>)["person"];
      profilePic = (snap.data() as Map<String, dynamic>)["profilePic"];
      bio = (snap.data() as Map<String, dynamic>)["bio"];
      college = (snap.data() as Map<String, dynamic>)["college"];
      followers = (snap.data() as Map<String, dynamic>)["followers"];
      isload = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isload
        ? Center(
            child: CircularProgressIndicator(
            color: Colors.blue,
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text('Profile'),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(profilePic),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${person} -',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            '${username}',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 30,
                        width: 200,
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey),
                        child: Center(
                            child:
                                Text(college, style: TextStyle(fontSize: 15)))),
                    Container(
                        height: 60,
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey),
                        child: Center(
                            child: Text(bio, style: TextStyle(fontSize: 15)))),
                    Container(
                        height: 45,
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 3, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.purple,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                    width: 45,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7),
                                    child: Text('${followers.length}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                                Container(
                                    width: 90,
                                    alignment: Alignment.topLeft,
                                    child: Text('Followers',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                              ],
                            ),
                            TextButton(
                                onPressed: () async {
                                  firestoreMethods().follow(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      widget.uid,
                                      followers);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: followers.contains(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          ? Colors.blue
                                          : Colors.blue),
                                  child: followers.contains(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      ? Text('Unfollow',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white))
                                      : Text('Follow',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                )),
                            Column(
                              children: [
                                Container(
                                    width: 45,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7),
                                    alignment: Alignment.topLeft,
                                    child: Text('${postlength}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                                Container(
                                    width: 60,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 7),
                                    alignment: Alignment.topLeft,
                                    child: Text('Posts',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                              ],
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 120,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.blue),
                                  child: Text('Ask question?',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                )),
                          ],
                        )),
                    Divider(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  type = 'photoposts';
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: type == 'photoposts'
                                        ? Colors.purple
                                        : Colors.grey,
                                  ),
                                  child: Text('Photos',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)))),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  type = 'videoposts';
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: type == 'videoposts'
                                        ? Colors.purple
                                        : Colors.grey,
                                  ),
                                  child: Text('Videos',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)))),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  type = 'booksposts';
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: type == 'booksposts'
                                        ? Colors.purple
                                        : Colors.grey,
                                  ),
                                  child: Text('Books',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)))),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  type = 'formulabookposts';
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 95,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: type == 'formulabookposts'
                                        ? Colors.purple
                                        : Colors.grey,
                                  ),
                                  child: Text('Formulabooks',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)))),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  type = 'otherposts';
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: type == 'otherposts'
                                        ? Colors.purple
                                        : Colors.grey,
                                  ),
                                  child: Text('others',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)))),
                        ]),
                    FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection(type)
                            .where('uid', isEqualTo: widget.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            );
                          }
                          return GridView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  (snapshot.data! as dynamic).docs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                childAspectRatio: 0.5,
                              ),
                              itemBuilder: (context, index) {
                                DocumentSnapshot snap =
                                    (snapshot.data! as dynamic).docs[index];

                                if (snap['type'] == 'Photo') {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color.fromARGB(
                                              255, 101, 101, 101),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 17,
                                                  backgroundImage: NetworkImage(
                                                      snap['profilePic']),
                                                ),
                                                Expanded(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            snap['username'],
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(snap['college'],
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          216,
                                                                          216)))
                                                        ],
                                                      ),
                                                      Text(
                                                          '~ ${snap['person']}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      102,
                                                                      158,
                                                                      255)))
                                                    ],
                                                  ),
                                                )),
                                                IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              Dialog(
                                                                  child:
                                                                      Container(
                                                                height: 45,
                                                                child: ListView(
                                                                  children: [
                                                                    'Report'
                                                                  ]
                                                                      .map((e) =>
                                                                          InkWell(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                                Container(
                                                                              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 17),
                                                                              child: Text(e),
                                                                            ),
                                                                          ))
                                                                      .toList(),
                                                                ),
                                                              )));
                                                    },
                                                    icon: Icon(Icons
                                                        .more_vert_rounded),
                                                    color: Colors.white)
                                              ],
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: snap[
                                                          'additionalText'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12))),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.37,
                                              width: double.infinity,
                                              child: Image.network(
                                                snap['postfileurl'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        DateFormat.yMMMd()
                                                            .format(snap['date']
                                                                .toDate()),
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    184,
                                                                    184,
                                                                    184)),
                                                      )),
                                                ),
                                                Expanded(
                                                    child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: IconButton(
                                                      onPressed: () {},
                                                      icon:
                                                          Icon(Icons.download)),
                                                ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (snap['type'] == 'Video') {
                                  void initState() {
                                    // TODO: implement initState
                                    super.initState();
                                    _videoPlayerController =
                                        VideoPlayerController.network(
                                            snap['postfileurl'])
                                          ..initialize().then((_) {
                                            setState(() {});
                                          });
                                  }

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color.fromARGB(
                                              255, 101, 101, 101),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 17,
                                                  backgroundImage: NetworkImage(
                                                      snap['profilePic']),
                                                ),
                                                Expanded(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            snap['username'],
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(snap['college'],
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          216,
                                                                          216)))
                                                        ],
                                                      ),
                                                      Text(
                                                          '~ ${snap['person']}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      102,
                                                                      158,
                                                                      255)))
                                                    ],
                                                  ),
                                                )),
                                                IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              Dialog(
                                                                  child:
                                                                      Container(
                                                                height: 45,
                                                                child: ListView(
                                                                  children: [
                                                                    'Report'
                                                                  ]
                                                                      .map((e) =>
                                                                          InkWell(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                                Container(
                                                                              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 17),
                                                                              child: Text(e),
                                                                            ),
                                                                          ))
                                                                      .toList(),
                                                                ),
                                                              )));
                                                    },
                                                    icon: Icon(Icons
                                                        .more_vert_rounded),
                                                    color: Colors.white)
                                              ],
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: snap[
                                                          'additionalText'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12))),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: _videoPlayerController !=
                                                            null &&
                                                        _videoPlayerController!
                                                            .value.isInitialized
                                                    ? AspectRatio(
                                                        aspectRatio:
                                                            _videoPlayerController!
                                                                .value
                                                                .aspectRatio,
                                                        child: VideoPlayer(
                                                          _videoPlayerController!,
                                                        ),
                                                      )
                                                    : Container(
                                                        child: Text(
                                                          "Error...can't load video",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )),
                                            Row(
                                              children: [
                                                FloatingActionButton(
                                                  onPressed: buttonpressed,
                                                  child: Icon(_videoPlayerController !=
                                                              null &&
                                                          _videoPlayerController!
                                                              .value.isPlaying
                                                      ? Icons.pause
                                                      : Icons
                                                          .play_arrow_rounded),
                                                ),
                                                Expanded(
                                                    child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: IconButton(
                                                      onPressed: () {},
                                                      icon:
                                                          Icon(Icons.download)),
                                                ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Text(
                                                        DateFormat.yMMMd()
                                                            .format(snap['date']
                                                                .toDate()),
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    184,
                                                                    184,
                                                                    184)),
                                                      )),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color.fromARGB(
                                              255, 101, 101, 101),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 17,
                                                  backgroundImage: NetworkImage(
                                                      snap['profilePic']),
                                                ),
                                                Expanded(
                                                    child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            snap['username'],
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(snap['college'],
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          218,
                                                                          216,
                                                                          216)))
                                                        ],
                                                      ),
                                                      Text(
                                                          '~ ${snap['person']}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      102,
                                                                      158,
                                                                      255)))
                                                    ],
                                                  ),
                                                )),
                                                IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              Dialog(
                                                                  child:
                                                                      Container(
                                                                height: 45,
                                                                child: ListView(
                                                                  children: [
                                                                    'Report'
                                                                  ]
                                                                      .map((e) =>
                                                                          InkWell(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                                Container(
                                                                              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 17),
                                                                              child: Text(e),
                                                                            ),
                                                                          ))
                                                                      .toList(),
                                                                ),
                                                              )));
                                                    },
                                                    icon: Icon(Icons
                                                        .more_vert_rounded),
                                                    color: Colors.white)
                                              ],
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: snap[
                                                          'additionalText'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12))),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 7),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Color.fromARGB(
                                                    255, 92, 91, 91),
                                              ),
                                              height: 100,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Icons.file_copy_outlined,
                                                    color: Colors.white,
                                                    size: 70,
                                                  ),
                                                  Text(snap['type'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'ananias',
                                                          letterSpacing: 2,
                                                          fontSize: 13,
                                                          color: Color.fromARGB(
                                                              255,
                                                              117,
                                                              245,
                                                              252))),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: IconButton(
                                                      onPressed: () {},
                                                      icon:
                                                          Icon(Icons.download)),
                                                ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Text(
                                                        DateFormat.yMMMd()
                                                            .format(snap['date']
                                                                .toDate()),
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    184,
                                                                    184,
                                                                    184)),
                                                      )),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              });
                        }),
                  ]),
            ));
  }
}
