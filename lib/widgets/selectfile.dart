import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
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
  File? file;
  @override
  Widget build(BuildContext context) {
    final filename = file != null ? basename(file!.path) : 'No file Selected';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AddPost()));
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text('Post image of your doubt'),
        centerTitle: false,
      ),
      body: Center(
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
            //       // image: DecorationImage(
            //       //     fit: BoxFit.contain, image: NetworkImage("")),
            //       ),
            IconButton(
              onPressed: fileSelect,
              icon: Icon(Icons.upload_file_outlined),
            ),

            Text(
              filename,
              style: TextStyle(fontWeight: FontWeight.bold),
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
