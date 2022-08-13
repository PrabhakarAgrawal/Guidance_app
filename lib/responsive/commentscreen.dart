import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/resources/firestoreMethods.dart';
import 'package:newapp/widgets/commentposting.dart';

class commentScreen extends StatefulWidget {
  final snap;
  commentScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<commentScreen> createState() => _commentScreenState();
}

class _commentScreenState extends State<commentScreen> {
  final TextEditingController _commentctrl = TextEditingController();
  String username = '';
  String uid = '';
  String profilePic = '';
  String person = '';

  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
  }

  Future<dynamic> getdetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)["username"];
      profilePic = (snap.data() as Map<String, dynamic>)["photoUrl"];
      uid = (snap.data() as Map<String, dynamic>)["uid"];
      person = (snap.data() as Map<String, dynamic>)["person"];
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentctrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        title: const Text(
          'Comments',
        ),
        centerTitle: false,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundimg.png'),
            opacity: 200.0,
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .orderBy('datePublished', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => commentPosting(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 50,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(84, 101, 101, 101),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profilePic),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: _commentctrl,
                    decoration: InputDecoration(
                      hintText: 'Type your answer',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(157, 255, 255, 255)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await firestoreMethods().postComment(widget.snap['postId'],
                      _commentctrl.text, uid, username, profilePic, person);
                  setState(() {
                    _commentctrl.text = '';
                  });
                },
                child: Container(
                  height: 50,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 139, 64, 251),
                  ),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
