import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/resources/firestoreMethods.dart';
import 'package:newapp/utils/utils.dart';

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
        .collection('aspirant')
        .doc('aspirant')
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snap.data() == null) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('guide')
          .doc('guide')
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      setState(() {
        username = (snap.data() as Map<String, dynamic>)["username"];
        uid = (snap.data() as Map<String, dynamic>)["uid"];
        profilePic = (snap.data() as Map<String, dynamic>)["photoUrl"];
      });
    } else {
      setState(() {
        username = (snap.data() as Map<String, dynamic>)["username"];
        uid = (snap.data() as Map<String, dynamic>)["uid"];
        profilePic = (snap.data() as Map<String, dynamic>)["photoUrl"];
      });
    }
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
    if (_file == null) {
      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 139, 64, 251),
            title: const Text('Post'),
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
              child: SingleChildScrollView(
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
                              onPressed: () {},
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
                                  color: Color.fromARGB(255, 255, 253, 253),
                                  fontSize: 20,
                                  fontFamily: 'ananias')),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 250.0,
                          alignment: Alignment.center,
                          child: Text('UPLOAD An image of your doubt',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 253, 253),
                                  fontSize: 20,
                                  fontFamily: 'ananias')),
                        ),
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
                                _imageselect(context);
                              },
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                size: 60.0,
                                color: Colors.white,
                              ),
                            )),
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.question_mark_outlined,
                                size: 60.0,
                                color: Colors.white,
                              ),
                            )),
                        Container(
                          width: 250.0,
                          alignment: Alignment.center,
                          child: Text('Type your question',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 253, 253),
                                  fontSize: 20,
                                  fontFamily: 'ananias')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 139, 64, 251),
          leading: IconButton(
              onPressed: () {
                setState(() {
                  _file = null;
                });
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: AspectRatio(
                    aspectRatio: 250 / 220,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain, image: MemoryImage(_file!)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white),
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
                    onTap: () => uploadImage(uid, username, profilePic),
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
      @override
      Widget build(BuildContext context) {
        return Container();
      }
    }
  }
}
