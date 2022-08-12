import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Map<String, dynamic> userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection("newusers")
        .where("person", isEqualTo: "Guide")
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Messages",
          style: TextStyle(fontFamily: 'quick'),
        )),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Container(
                  child: TextField(
                controller: _search,
                decoration: InputDecoration(
                    hintText: ("Search"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              )),
            ),
            ElevatedButton(
                onPressed: onSearch,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text("Search"))
          ],
        ));
  }
}
