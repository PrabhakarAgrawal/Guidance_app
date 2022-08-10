import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newapp/widgets/photoposting.dart';

class contentPage extends StatefulWidget {
  contentPage({Key? key}) : super(key: key);

  @override
  State<contentPage> createState() => _contentPageState();
}

class _contentPageState extends State<contentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(212, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        centerTitle: true,
        title: Text('feed'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.chat_bubble_outlined))
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/backgroundimg.png",
            ),
            opacity: 200.0,
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => photoPosting(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          },
        ),
      ),
    );
  }
}
