import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newapp/responsive/veiwpdf.dart';

class listOfStudyMaterial extends StatefulWidget {
  final type;
  const listOfStudyMaterial({Key? key, required this.type}) : super(key: key);

  @override
  State<listOfStudyMaterial> createState() => _listOfStudyMaterialState();
}

class _listOfStudyMaterialState extends State<listOfStudyMaterial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        title: Text(
          'Study Matrial',
          style: TextStyle(fontFamily: 'quick'),
        ),
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
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection(widget.type).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            return SingleChildScrollView(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap =
                        (snapshot.data! as dynamic).docs[index];

                    if (snap['type'] == 'Photo') {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromARGB(255, 101, 101, 101),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 17,
                                      backgroundImage:
                                          NetworkImage(snap['profilePic']),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snap['username'],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Text(snap['college'],
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Color.fromARGB(
                                                          255, 218, 216, 216)))
                                            ],
                                          ),
                                          Text('~ ${snap['person']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.greenAccent))
                                        ],
                                      ),
                                    )),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                      child: Container(
                                                    height: 45,
                                                    child: ListView(
                                                      children: ['Report']
                                                          .map((e) => InkWell(
                                                                onTap: () {},
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          13,
                                                                      horizontal:
                                                                          17),
                                                                  child:
                                                                      Text(e),
                                                                ),
                                                              ))
                                                          .toList(),
                                                    ),
                                                  )));
                                        },
                                        icon: Icon(Icons.more_vert_rounded),
                                        color: Colors.white)
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(bottom: 10, top: 10),
                                  child: RichText(
                                      text: TextSpan(
                                          text: snap['additionalText'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12))),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.37,
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
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            DateFormat.yMMMd()
                                                .format(snap['date'].toDate()),
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 184, 184, 184)),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromARGB(255, 101, 101, 101),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 17,
                                      backgroundImage:
                                          NetworkImage(snap['profilePic']),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snap['username'],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Text(snap['college'],
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Color.fromARGB(
                                                          255, 218, 216, 216)))
                                            ],
                                          ),
                                          Text('~ ${snap['person']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.greenAccent))
                                        ],
                                      ),
                                    )),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                      child: Container(
                                                    height: 45,
                                                    child: ListView(
                                                      children: ['Report']
                                                          .map((e) => InkWell(
                                                                onTap: () {},
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          13,
                                                                      horizontal:
                                                                          17),
                                                                  child:
                                                                      Text(e),
                                                                ),
                                                              ))
                                                          .toList(),
                                                    ),
                                                  )));
                                        },
                                        icon: Icon(Icons.more_vert_rounded),
                                        color: Colors.white)
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(bottom: 10, top: 10),
                                  child: RichText(
                                      text: TextSpan(
                                          text: snap['additionalText'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12))),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color.fromARGB(255, 92, 91, 91),
                                  ),
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.file_copy_outlined,
                                        color: Colors.white,
                                        size: 70,
                                      ),
                                      Text(snap['type'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'ananias',
                                              letterSpacing: 2,
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 117, 245, 252))),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => loadpdf(
                                                        url:
                                                            snap['postfileurl'],
                                                      )));
                                        },
                                        icon: Icon(Icons.remove_red_eye),
                                        color: Colors.white,
                                      ),
                                    ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            DateFormat.yMMMd()
                                                .format(snap['date'].toDate()),
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 184, 184, 184)),
                                          )),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            );
          },
        ),
      ),
    );
  }
}
