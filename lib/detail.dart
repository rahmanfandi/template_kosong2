import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

// List<String> entries = <String>[];
// List<int> colorCodes = <int>[600, 500, 100, 200, 300];

String? title;
String? body;
String? tag;

class detail extends StatefulWidget {
  String? docid;
  detail({super.key, @required this.docid});

  @override
  State<detail> createState() => _Detail();
}

class _Detail extends State<detail> {
  @override
  void initState() {
    super.initState();

    //print(widget.docid);
    readfire();
  }

  Future<void> readfire() async {
    FirebaseFirestore.instance
        .collection('note')
        .doc(widget.docid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print("test detail");
        // print(documentSnapshot["title"]);

        setState(() {
          title = documentSnapshot["title"];
          body = documentSnapshot["body"];
          tag = documentSnapshot["tag"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text("halo"),
          backgroundColor: Colors.teal,
          title: Text("$title",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'edit',
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(1),
              margin: const EdgeInsets.all(1),
              //height: 50,
              //color: Colors.amber[colorCodes[index]],
              color: Colors.amber,

              child: Text(
                "$title",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(1),
              margin: const EdgeInsets.all(1),
              // height: 200,
              //color: Colors.amber[colorCodes[index]],
              color: Colors.amber,
              child: Text("$body"),
            ),
            Container(
              padding: const EdgeInsets.all(1),
              margin: const EdgeInsets.all(1),
              height: 50,
              //color: Colors.amber[colorCodes[index]],
              color: Colors.amber,
              child: Text("$tag"),
            ),
          ],
        ));

    // Container(color: Color.fromARGB(255, 169, 255, 254));
  }
}
