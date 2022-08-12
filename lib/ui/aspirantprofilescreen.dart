import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class aspirantProfileScreen extends StatefulWidget {
  const aspirantProfileScreen({Key? key}) : super(key: key);

  @override
  State<aspirantProfileScreen> createState() => _aspirantProfileScreenState();
}

class _aspirantProfileScreenState extends State<aspirantProfileScreen> {
  String username = '';
  String person = '';
  String profilePic = '';
  String bio = '';
  String uid = '';
  String college = '';
  List followers = [];
  int postlength = 0;
  String postfileurl = '';
  bool isload = false;

  @override
  void initState() {
    super.initState();
    getdetails();
  }

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

    setState(() {
      postlength = postsnap.docs.length;

      username = (snap.data() as Map<String, dynamic>)["username"];
      person = (snap.data() as Map<String, dynamic>)["person"];
      profilePic = (snap.data() as Map<String, dynamic>)["profilePic"];
      bio = (snap.data() as Map<String, dynamic>)["bio"];
      uid = (snap.data() as Map<String, dynamic>)["uid"];
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
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 139, 64, 251),
              title: Text(
                'Profile',
                style: TextStyle(fontFamily: 'quick'),
              ),
              centerTitle: false,
            ),
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgroundimg.png'),
                  opacity: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  // constraints: BoxConstraints.expand(),
                  // decoration: const BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage(
                  //       "assets/images/backgroundimg.png",
                  //     ),
                  //     opacity: 200.0,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
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
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            Text(
                              '${username}',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
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
                              child: Text(bio,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)))),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          height: 45,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 3, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 139, 64, 251),
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 7),
                                      width: 90,
                                      alignment: Alignment.topLeft,
                                      child: Text('Following',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)))),
                                ],
                              ),
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
                            ],
                          )),
                      Divider(),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.all(8),
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Center(
                            child: Text('Questions',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          )),
                      FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('posts')
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
                                });
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
