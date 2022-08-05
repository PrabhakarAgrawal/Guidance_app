import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newapp/utils/utils.dart';

class AddPost extends StatefulWidget {
  AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file;
  final TextEditingController _addtionalTextController =
      TextEditingController();
  //post question
  void postDoubt(String id, String username) {}
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

  @override
  Widget build(BuildContext context) {
    if (_file == null) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 139, 64, 251),
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
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
                      width: 250.0,
                      alignment: Alignment.center,
                      child: Text('UPLOAD An image of your doubt',
                          style: TextStyle(
                              color: Color.fromARGB(255, 68, 67, 67),
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
                              color: Color.fromARGB(255, 68, 67, 67),
                              fontSize: 20,
                              fontFamily: 'ananias')),
                    ),
                  ],
                ),
              ],
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 139, 64, 251),
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          title: const Text('Post'),
          centerTitle: false,
        ),
        body: Center(
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
                    color: Color.fromARGB(255, 203, 203, 203)),
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
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(12.0),
                      color: Color.fromARGB(255, 139, 64, 251),
                    ),
                    child: Text('UPLOAD',
                        style: TextStyle(
                          fontFamily: "ananias",
                          color: Colors.white,
                          fontSize: 20,
                        )),
                  ))
            ],
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
