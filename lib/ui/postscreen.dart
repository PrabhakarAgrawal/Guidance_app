import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/resources/firestoreMethods.dart';
import 'package:newapp/utils/utils.dart';
import 'package:newapp/widgets/selectfile.dart';

class AddPost extends StatefulWidget {
  AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String uid = '';
  String username = '';
  String profilePic = '';
  String college = '';
  String person = '';
  Uint8List? _file;
  bool _isLoading = false;
  final TextEditingController _addtionalTextController =
      TextEditingController();
  //post question
  void uploadImage(String uid, String username, String profilePic) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await firestoreMethods().uploadPost(username, uid,
          profilePic, _addtionalTextController.text, college, person, _file!);
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

  //image picking option
  _imageselect(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
              title: const Text('Create a Post'),
              children: <Widget>[
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20.0),
                  child: const Text('Take a photo'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickPhoto(
                      ImageSource.camera,
                    );
                    setState(() {
                      _file = file;
                    });
                  },
                ),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20.0),
                  child: const Text('Select from gallery'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickPhoto(
                      ImageSource.gallery,
                    );
                    setState(() {
                      _file = file;
                    });
                  },
                ),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20.0),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _addtionalTextController.dispose();
  }

  void clearPhotoPosting() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 139, 64, 251),
          title: const Text('Post'),
          centerTitle: false,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 100.0,
                      width: 100.0,
                      margin: EdgeInsets.only(top: 50.0, bottom: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Color.fromARGB(255, 139, 64, 251)),
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => selectFile()));
                        },
                        icon: Icon(
                          Icons.upload_file,
                          size: 60.0,
                          color: Colors.white,
                        ),
                      )),
                  Container(
                    width: 250.0,
                    alignment: Alignment.center,
                    child: Text('UPLOAD A FILE',
                        style: TextStyle(
                            color: Color.fromARGB(255, 68, 67, 67),
                            fontSize: 20,
                            fontFamily: 'ananias')),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 100.0,
                      width: 100.0,
                      margin: EdgeInsets.only(top: 50.0, bottom: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Color.fromARGB(255, 139, 64, 251)),
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => selectFile()));
                        },
                        icon: Icon(
                          Icons.video_call_rounded,
                          size: 60.0,
                          color: Colors.white,
                        ),
                      )),
                  Container(
                    width: 250.0,
                    alignment: Alignment.center,
                    child: Text('Upload a video',
                        style: TextStyle(
                            color: Color.fromARGB(255, 68, 67, 67),
                            fontSize: 20,
                            fontFamily: 'ananias')),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
