import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_4/home.dart';
import 'package:flutter_application_4/navigation.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _login();
}

class _login extends State<login> {
  @override
  void initState() {
    super.initState();
    cek_login();
  }

  cek_login() async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        //     print('User is currently signed out!');
      } else {
        //   print('User is signed in!');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => navigation()),
        );
      }
    });
  }

  login(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      cek_login();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  dekor(String label, Icon ikon) {
    Color color1 = Color.fromARGB(255, 240, 219, 253);
    return InputDecoration(
        prefixIcon: ikon,
        suffixIcon: Icon(Icons.visibility),
        labelText: '$label',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        filled: true,
        fillColor: color1);
  }

  Color color1 = Color.fromARGB(255, 251, 231, 255);
  @override
  Widget build(BuildContext context) {
    //  TextEditingController username = TextEditingController();
    //  TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    // gambar();
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 237, 207, 243),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: const TextStyle(fontSize: 30, color: Colors.black));

    // print("tes dulu");
    // print(lokasi);

    return Scaffold(
        body: Container(
            color: Color.fromARGB(255, 229, 246, 222),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(),
                Container(
                  //  color: Color.fromARGB(255, 227, 185, 255),
                  margin: const EdgeInsets.all(5),
                  child: TextFormField(
                      controller: email,
                      decoration: dekor("email", Icon(Icons.mail))),
                ),
                Container(
                  //  color: Color.fromARGB(255, 227, 185, 255),
                  margin: const EdgeInsets.all(5),
                  child: TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: dekor("password", Icon(Icons.lock))),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: style,
                    onPressed: () {
                      login(email.text, password.text);
                    },
                    child: const Text('Sign-In'),
                  ),
                ),
                Container(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {},
                    child: const Text('Sing-UP new Acount'),
                  ),
                )
              ],
            )));
  }
}
