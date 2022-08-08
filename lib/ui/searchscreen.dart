import 'package:flutter/material.dart';

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
        title: Form(
          child: Container(
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
                print(_);
              },
            ),
          ),
        ),
      ),
    );
  }
}
