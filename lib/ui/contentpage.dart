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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        centerTitle: true,
        title: Text('feed'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.chat_bubble_outlined))
        ],
      ),
      body: photoPosting(),
    );
  }
}
