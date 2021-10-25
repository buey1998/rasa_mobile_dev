import 'dart:math';

import 'package:bueytest/bloc/authentication_bloc.dart';
import 'package:bueytest/style/textstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  late String fullname, email, password;

  signUp() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();
    if (password == confirmPassword && password.length >= 6) {
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        print("Sign up user successful.");
      }).catchError((error) {
        print(error.message);
      });
    } else {
      print("Password and Confirm-password is not match.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สมัคสมาชิก',
          style: wh20Style,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        listener: (context, state) {
          if (state is SignUpSucess) {
            Navigator.pop(context);
          } else {}
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(
              children: [
                TextField(
                  style: bl113Style,
                  onChanged: (value) => fullname = value,
                  decoration: InputDecoration(
                    hintText: 'ชื่อ - นามสกุล',
                    hintStyle: bl113Style,
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                TextField(
                  controller: emailController,
                  style: bl113Style,
                  onChanged: (value) =>
                      emailController = value as TextEditingController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: bl113Style,
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                TextField(
                  controller: passwordController,
                  style: bl113Style,
                  onChanged: (value) =>
                      passwordController = value as TextEditingController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: bl113Style,
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                TextField(
                  controller: confirmController,
                  style: bl113Style,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: bl113Style,
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Container(
                    color: Colors.grey[100],
                    // height: 200,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password ต้องประกอบไปด้วย :',
                            style: bl20Style,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'จำนวนอักขระรวมกันไม่น้อยกว่า 8 ตัว',
                            style: bl11Style,
                          ),
                          Text(
                            'ตัวอักษรพิมพ์ใหญ่ (A-Z) อย่างน้อย 1 ตัว',
                            style: bl11Style,
                          ),
                          Text(
                            'ตัวอักษรพิมพ์เล็ก (a-z) อย่างน้อย 1 ตัว',
                            style: bl11Style,
                          ),
                          Text(
                            'ตัวเลข (0-9) อย่างน้อย 1 ตัว',
                            style: bl11Style,
                          ),
                        ],
                      ),
                    ),
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
                      'สมัครสมาชิก',
                      style: wt15Style,
                    ),
                    onPressed: () {
                      signUp();
                      // authenticationBloc.add(SignUp(fullname, email, password));
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => APIPage()));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
