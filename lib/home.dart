import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/detail.dart';
import 'package:flutter_application_4/login.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

List<String> entries = <String>[];
List<String> noteid = <String>[];
List<int> colorCodes = <int>[600, 500, 100, 200, 300];

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _Home();
}

class _Home extends State<home> {
  @override
  void initState() {
    super.initState();

    readfire();

    //image.color.red.
  }

  int _selectedIndex = 0;

  Future<void> readfire() async {
    entries.clear();
    FirebaseFirestore.instance
        .collection('note')
        .get()
        .then((QuerySnapshot querySnapshot) {
      //print(querySnapshot.docs.map((doc) => doc["title"]));
      //entries = querySnapshot.docs.map((doc) => doc["title"]).toList();

      querySnapshot.docs.forEach((doc) {
        // print(doc["title"]);
        // print(doc.id);
        setState(() {
          entries.add(doc["title"]);
          noteid.add(doc.id);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 227, 164, 239),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: const TextStyle(fontSize: 20));
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
        body: ListView.builder(
            padding: const EdgeInsets.all(1),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: Container(
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.all(1),
                  height: 50,
                  //color: Colors.amber[colorCodes[index]],
                  color: Colors.amber,
                  child: Center(child: Text('Entry ${entries[index]}')),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => detail(
                              docid: noteid[index],
                            )),
                  );

                  //print(

                  //const String id = noteid[index];

                  //  "yang di klik adalah index ke $index  berisi ${entries[index]} dengan noteid ${noteid[index]}");
                },
              );
            }));

    // Container(color: Color.fromARGB(255, 169, 255, 254));
  }
}
