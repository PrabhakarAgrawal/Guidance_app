import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newapp/resources/firestoreMethods.dart';
import 'package:newapp/responsive/veiwpdf.dart';
import 'package:newapp/utils/utils.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:video_player/video_player.dart';

class guideProfileScreen extends StatefulWidget {
  guideProfileScreen({Key? key}) : super(key: key);

  @override
  State<guideProfileScreen> createState() => _guideProfileScreenState();
}

class _guideProfileScreenState extends State<guideProfileScreen> {
  String username = '';
  String person = '';
  String profilePic = '';
  String bio = '';
  String uid = '';
  String email = '';
  String college = '';
  List followers = [];
  int postlength = 0;
  String postfileurl = '';
  bool isload = false;
  String type = 'photoposts';
  Dio? dio;
  @override
  void initState() {
    dio = Dio();
    super.initState();
    getdetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // Future<List<Directory>?> _getExternalStoragePath() {
  //   return p.getExternalStorageDirectories(type: p.StorageDirectory.downloads);
  // }

  // Future downloadfile(String url, String filename) async {
  //   try {
  //     final dlist = await _getExternalStoragePath();
  //     final path = dlist![0].path;
  //     final file = File('$path' + '/filename');
  //     await dio!.download(url, file);
  //     filefullpath = file.path;
  //     showSnackBAr('downloaded', context);
  //     print('success');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void buttonpressed() {
  //   if (_videoPlayerController != null) {
  //     setState(() {
  //       _videoPlayerController!.value.isPlaying
  //           ? _videoPlayerController!.pause()
  //           : _videoPlayerController!.play();
  //     });
  //   }
  // }

  Future<dynamic> getdetails() async {
    setState(() {
      isload = true;
    });
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var postsnap = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    postlength = postsnap.docs.length;
    @override
    void initState() {
      super.initState();

      // _videoPlayerController =
      //     VideoPlayerController.network(snap['postfileurl'])
      //       ..initialize().then((_) {
      //         setState(() {});
      //       });
    }

    setState(() {
      postlength = postsnap.docs.length;

      username = (snap.data() as Map<String, dynamic>)["username"];
      person = (snap.data() as Map<String, dynamic>)["person"];
      profilePic = (snap.data() as Map<String, dynamic>)["profilePic"];
      bio = (snap.data() as Map<String, dynamic>)["bio"];
      uid = (snap.data() as Map<String, dynamic>)["uid"];
      college = (snap.data() as Map<String, dynamic>)["college"];
      followers = (snap.data() as Map<String, dynamic>)["followers"];
      email = (snap.data() as Map<String, dynamic>)["email"];

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
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text('Profile', style: TextStyle(fontFamily: 'ananias')),
              centerTitle: false,
            ),
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgroundimg.png'),
                  opacity: 210.0,
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
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
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.greenAccent,
                                  fontFamily: 'ananias'),
                            ),
                            Text(' ${username}',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontFamily: 'ananias')),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          height: 60,
                          width: double.infinity,
                          margin:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(186, 91, 90, 90)),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Bio - $bio',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  'College - $college',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  'Email - $email',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                )
                              ],
                            ),
                          )),
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
                              // TextButton(
                              //     onPressed: () {},
                              //     child: Container(
                              //       alignment: Alignment.center,
                              //       width: 70,
                              //       height: 30,
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(12),
                              //           color: Colors.blue),
                              //       child: Text('Follow',
                              //           style: TextStyle(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.bold,
                              //               color: Colors.white)),
                              //     )),
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
                              // TextButton(
                              //     onPressed: () {},
                              //     child: Container(
                              //       alignment: Alignment.center,
                              //       width: 120,
                              //       height: 30,
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(12),
                              //           color: Colors.blue),
                              //       child: Text('Ask question?',
                              //           style: TextStyle(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.bold,
                              //               color: Colors.white)),
                              //     )),
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
                                          : Color.fromARGB(186, 91, 90, 90),
                                    ),
                                    child: Text('Photos',
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
                                          : Color.fromARGB(186, 91, 90, 90),
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
                                          : Color.fromARGB(186, 91, 90, 90),
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
                                          : Color.fromARGB(186, 91, 90, 90),
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
                              .where('uid',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
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
                            return SingleChildScrollView(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      (snapshot.data! as dynamic).docs.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 1.25,
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
                                                      backgroundImage:
                                                          NetworkImage(snap[
                                                              'profilePic']),
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
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                snap[
                                                                    'username'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                  snap[
                                                                      'college'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Color.fromARGB(
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
                                                                  color: Colors
                                                                      .greenAccent))
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
                                                                    child:
                                                                        ListView(
                                                                      children: [
                                                                        'Report'
                                                                      ]
                                                                          .map((e) =>
                                                                              InkWell(
                                                                                onTap: () {},
                                                                                child: Container(
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
                                                  margin: EdgeInsets.only(
                                                      bottom: 10, top: 10),
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: snap[
                                                              'additionalText'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            DateFormat.yMMMd()
                                                                .format(snap[
                                                                        'date']
                                                                    .toDate()),
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        184,
                                                                        184,
                                                                        184)),
                                                          )),
                                                    ),
                                                  ],
                                                ),
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
                                                      backgroundImage:
                                                          NetworkImage(snap[
                                                              'profilePic']),
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
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                snap[
                                                                    'username'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                  snap[
                                                                      'college'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Color.fromARGB(
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
                                                                  color: Colors
                                                                      .greenAccent))
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
                                                                    child:
                                                                        ListView(
                                                                      children: [
                                                                        'Report'
                                                                      ]
                                                                          .map((e) =>
                                                                              InkWell(
                                                                                onTap: () {},
                                                                                child: Container(
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
                                                  margin: EdgeInsets.only(
                                                      bottom: 10, top: 10),
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text: snap[
                                                              'additionalText'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12))),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 7),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                                        Icons
                                                            .file_copy_outlined,
                                                        color: Colors.white,
                                                        size: 70,
                                                      ),
                                                      Text(snap['type'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'ananias',
                                                              letterSpacing: 2,
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromARGB(
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
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          loadpdf(
                                                                            url:
                                                                                snap['postfileurl'],
                                                                          )));
                                                        },
                                                        icon: Icon(Icons
                                                            .remove_red_eye),
                                                        color: Colors.white,
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Text(
                                                            DateFormat.yMMMd()
                                                                .format(snap[
                                                                        'date']
                                                                    .toDate()),
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
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
                                  }),
                            );
                          }),
                    ]),
              ),
            ));
  }
}
