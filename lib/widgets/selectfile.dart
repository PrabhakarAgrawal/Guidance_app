import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:newapp/responsive/mobilescreen_layout.dart';
import 'package:newapp/utils/utils.dart';
import 'package:path/path.dart';
import '../resources/firebaseApi.dart';
import '../resources/firestoreMethods.dart';
import '../ui/postscreen.dart';

class selectFile extends StatefulWidget {
  selectFile({Key? key}) : super(key: key);

  @override
  State<selectFile> createState() => _selectFileState();
}

class _selectFileState extends State<selectFile> {
  final TextEditingController _addtionalTextController =
      TextEditingController();
  bool _isLoading = false;
  String college = '';
  String person = '';
  String uid = '';
  String type = '';
  String username = '';
  String profilePic = '';
  String? value;
  File? file;
  final items = ['Handwritten notes', 'Formulabook', 'Books', 'Photo', 'Video'];
  DropdownMenuItem<String> buildmenuitem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  void uploadFile(String uid, String username, String profilePic) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await firestoreMethods().uploadFile(
          username,
          uid,
          profilePic,
          type,
          _addtionalTextController.text,
          college,
          person,
          file!);
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBAr('Posted', context);
        clearPhotoPosting();
      } else {
        showSnackBAr(res, context);
      }
    } catch (e) {
      showSnackBAr(e.toString(), context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
  }

  void getdetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('newusers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)["username"];
      uid = (snap.data() as Map<String, dynamic>)["uid"];
      profilePic = (snap.data() as Map<String, dynamic>)["profilePic"];
      college = (snap.data() as Map<String, dynamic>)["college"];
      person = (snap.data() as Map<String, dynamic>)["person"];
    });
  }

  void clearPhotoPosting() {
    setState(() {
      file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filename = file != null ? basename(file!.path) : 'No file Selected';
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MobileScreenLayout()));
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text('Post image of your doubt'),
        centerTitle: false,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.3,
              //   width: MediaQuery.of(context).size.width * 0.55,
              // child: AspectRatio(
              //   aspectRatio: 250 / 220,
              // child: Container(
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           fit: BoxFit.contain, image: NetworkImage("")),
              //       )),
              Container(
                width: 150,
                height: 150,
                child: file != null
                    ? Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1659904825585-2fdf22b3aa73?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"))))
                    : IconButton(
                        onPressed: fileSelect,
                        icon: Icon(Icons.upload_file_outlined),
                        color: Colors.white,
                        iconSize: 50,
                      ),
              ),

              Text(
                filename,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Container(
                color: Color.fromARGB(255, 8, 0, 0),
                // width: 300,
                margin: EdgeInsets.all(10),
                child: DropdownButton<String>(
                  hint: Text(
                    "Select type of file",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  value: value,
                  items: items.map(buildmenuitem).toList(),
                  onChanged: (value) => setState(() {
                    this.value = value;
                    type = value!;
                    // Colors.white;
                  }),
                ),
              ),

              Container(
                margin: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color.fromARGB(255, 255, 255, 255)),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _addtionalTextController,
                    decoration: const InputDecoration(
                        hintText: 'Write addtional text',
                        border: InputBorder.none),
                    maxLines: 8,
                  ),
                ),
              ),
              InkWell(
                  onTap: () => file == null
                      ? Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AddPost()))
                      : uploadFile(uid, username, profilePic),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(12.0),
                      color: Color.fromARGB(255, 139, 64, 251),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("upload",
                            style: TextStyle(
                              fontFamily: "ananias",
                              color: Colors.white,
                              fontSize: 20,
                            )),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future fileSelect() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }
}
