import 'package:flutter/material.dart';
import 'package:newapp/widgets/listofstudymaterial.dart';

class StudyMaterial extends StatefulWidget {
  const StudyMaterial({Key? key}) : super(key: key);

  @override
  State<StudyMaterial> createState() => _StudyMaterialState();
}

class _StudyMaterialState extends State<StudyMaterial> {
  // var current_type = 'Books';

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
                        fontSize: MediaQuery.of(context).size.height * 0.038,
                        fontFamily: 'ananias'),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(12),
                    color: Color.fromARGB(255, 161, 75, 210),
                  ),
                  width: double.infinity,
                  margin: EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              listOfStudyMaterial(type: 'booksposts')));
                    },
                    child: Text(
                      'Books',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.032),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(12),
                    color: Color.fromARGB(255, 161, 75, 210),
                  ),
                  width: double.infinity,
                  margin: EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              listOfStudyMaterial(type: 'formulabookposts')));
                    },
                    child: Text(
                      'Formulabooks',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.032),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(12),
                    color: Color.fromARGB(255, 161, 75, 210),
                  ),
                  width: double.infinity,
                  margin: EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              listOfStudyMaterial(type: 'otherposts')));
                    },
                    child: Text(
                      'Handnotes',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.032),
                    ),
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
