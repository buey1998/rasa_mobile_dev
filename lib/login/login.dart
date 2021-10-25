import 'package:bueytest/login/APIpage.dart';
import 'package:bueytest/login/SignUp.dart';
import 'package:bueytest/style/textstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  signIn() {
    _auth
        .signInWithEmailAndPassword(
            // email: "buey.rasa@gmail.com", password: "12345678")
            email: "$email",
            password: "$password")
        .then((user) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => APIPage(user: _auth.currentUser!.uid)));
      // print("signed in ${user.email}");
    }).catchError((error) {
      print('error------$error');
    });
  }

  Future checkAuth(BuildContext context) async {
    // FirebaseUser user = await _auth.currentUser();
    if (_auth.currentUser != null) {
      print("Already singed-in with");
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => APIPage(user: _auth.currentUser!.uid)));
      });
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   checkAuth(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text('เข้าสู่ระบบ', style: bl20Style),
              ),
            ),
            TextField(
              style: bl113Style,
              // controller: searchController,
              onChanged: (value) => email = value,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: bl113Style,
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                // enabledBorder: InputBorder.none,
                // focusedBorder: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: bl113Style,
              // controller: searchController,
              onChanged: (value) => password = value,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: bl113Style,
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                // enabledBorder: InputBorder.none,
                // focusedBorder: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  // primary: Colors.purple,
                  backgroundColor: Colors.black,
                ),
                // color: Colors.black,
                child: Text(
                  'เข้าสู่ระบบ',
                  style: wt15Style,
                ),
                onPressed: () {
                  signIn();
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  'หรือเข้าสู่ระบบด้วย',
                  style: bl15Style,
                )),
            Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  // primary: Colors.purple,
                  backgroundColor: Colors.black,
                ),
                // color: Colors.black,
                child: Text(
                  'Facebook',
                  style: wt15Style,
                ),
                onPressed: () {},
              ),
            ),
            Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  // primary: Colors.purple,
                  backgroundColor: Colors.black,
                ),
                // color: Colors.black,
                child: Text(
                  'Gmail',
                  style: wt15Style,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text(
                  'สมัครสมาชิก',
                  style: bl15Style,
                ),
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(width: 2, color: Colors.black)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                  // textStyle:
                  //     MaterialStateProperty.all(TextStyle(fontSize: 30))
                )),
          ],
        ),
      ),
    );
  }
}
