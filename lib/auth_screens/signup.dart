import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hatchbox_v2/auth_screens/datab.dart';
import 'package:hatchbox_v2/prod_screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Regorg extends StatefulWidget {
  const Regorg({Key? key}) : super(key: key);

  @override
  State<Regorg> createState() => _RegorgState();
}

class _RegorgState extends State<Regorg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return SignupPage();
            }
          },
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phController = TextEditingController();
  final usernameController = TextEditingController();
  final snackBar = SnackBar(content: Text('Welcome to HatchBox'));
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(children: <Widget>[
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Create an account",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )
              ]),
              Column(
                children: <Widget>[
                  inputFile(usernameController,label: "Username"),
                  inputFile(emailController,label: "Email"),
                  inputFile(passController,label: "Password", obsureText: true),
                  inputFile(passController,label: "Confirm Password", obsureText: true),
                  inputFile(phController,label:"Phone Number"),

                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed:signUp,
                  color: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget inputFile(TextEditingController controller,{label, obsureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          obscureText: obsureText,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.grey),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
  Future signUp() async {
    try {
      print(emailController.text.toString());

      UserCredential result =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.toLowerCase().trim(),
        password: passController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      User? user = result.user;
      await DatabaseService(uid:user!.uid).updateUserData( usernameController.text, phController.text,"222",emailController.text,passController.text,"");
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}



