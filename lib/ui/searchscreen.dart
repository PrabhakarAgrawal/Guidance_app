import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newapp/ui/searchguideprofile.dart';

class searchScreen extends StatefulWidget {
  searchScreen({Key? key}) : super(key: key);

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  bool showUsers = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(255, 165, 165, 165),
            ),
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: searchCtrl,
              decoration: const InputDecoration(labelText: 'Search users'),
              onFieldSubmitted: (String _) {
                setState(() {
                  showUsers = true;
                });
              },
            ),
          ),
        ),
        body: showUsers
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('newusers')
                    .where('username', isGreaterThanOrEqualTo: searchCtrl.text)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => searchGuideProfile(
                                    uid: (snapshot.data! as dynamic).docs[index]
                                        ['uid']))),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['profilePic'],
                            ),
                          ),
                          title: Column(
                            children: [
                              Text(
                                (snapshot.data! as dynamic).docs[index]
                                    ['username'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 43, 129, 187)),
                              ),
                              Text(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['college'],
                                  style: TextStyle(
                                      fontSize: 11,
                                      color:
                                          Color.fromARGB(255, 115, 115, 115)))
                            ],
                          ),
                          trailing: Text(
                              '~ ${(snapshot.data! as dynamic).docs[index]['person']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 102, 158, 255))),
                        ),
                      );
                    }),
                  );
                })
            : Center(
                child: Container(
                    height: 200,
                    width: 200,
                    child: Icon(Icons.search_outlined,
                        color: Colors.blueGrey, size: 80)),
              ));
  }
}
