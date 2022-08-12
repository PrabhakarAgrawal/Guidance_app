import 'package:flutter/material.dart';

class StudyMaterial extends StatefulWidget {
  const StudyMaterial({Key? key}) : super(key: key);

  @override
  State<StudyMaterial> createState() => _StudyMaterialState();
}

class _StudyMaterialState extends State<StudyMaterial> {
  String? value;
  String type = '';
  final types = ['Books', 'Formulabooks', 'videos'];
  // var current_type = 'Books';

  DropdownMenuItem<String> buildmenuitem(String type) => DropdownMenuItem(
        value: type,
        child: Text(
          type,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 64, 251),
        title: Text(
          'Study Matetial',
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Get the Study Material here',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  color: Color.fromARGB(255, 8, 0, 0),
                  // width: 300,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: DropdownButton<String>(
                    hint: Center(
                      child: Text(
                        "Select type of Study Material",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    value: value,
                    items: types.map(buildmenuitem).toList(),
                    onChanged: (value) => setState(() {
                      this.value = value;
                      type = value!;
                      // Colors.white;
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
