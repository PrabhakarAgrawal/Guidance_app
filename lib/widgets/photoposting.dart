import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

class photoPosting extends StatelessWidget {
  const photoPosting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                        NetworkImage("https://unsplash.com/photos/98HGH2wPaCo"),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text('IIT Indore',
                            style: TextStyle(
                                fontSize: 11,
                                color: Color.fromARGB(255, 218, 216, 216)))
                      ],
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                    child: ListView(
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  children: ['Delete']
                                      .map((e) => InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 13, horizontal: 17),
                                              child: Text(e),
                                            ),
                                          ))
                                      .toList(),
                                )));
                      },
                      icon: Icon(Icons.more_vert_rounded),
                      color: Colors.white)
                ],
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(7),
                child: RichText(
                    text: TextSpan(
                        text: 'discription to be replaced hehehehehhehe',
                        style: TextStyle(color: Colors.white, fontSize: 12))),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.37,
                width: double.infinity,
                child: Image.network(
                  'https://images.unsplash.com/photo-1659641926134-d80cb09ba024?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.thumb_up_alt_rounded,
                          color: Colors.white)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.question_answer_rounded,
                          color: Colors.white)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.send_rounded, color: Colors.white)),
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.download)),
                  ))
                ],
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: Text('420',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text('40',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
