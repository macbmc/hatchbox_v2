import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hatchbox_v2/auth_screens/login.dart';
class ScreenForgotPassword extends StatefulWidget {
  const ScreenForgotPassword({Key? key}) : super(key: key);

  @override
  State<ScreenForgotPassword> createState() => _ScreenForgotPasswordState();
}

class _ScreenForgotPasswordState extends State<ScreenForgotPassword> {
  final emailcontroller = TextEditingController();
  //final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text('Please enter your email address. You will receive a link to create a new password via email.'),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: emailcontroller,
              decoration: const InputDecoration(
                labelText: 'EMAIL',
                hintText: 'mariahfranklin@mail.com',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed:_restpassword,
                /*auth.sendPasswordResetEmail(email: _controller.text
                ).then((value) => Utils().toastMessage('We have sent you an email to recover password, please check your mail')
                ).onError((error,stackTrace) => Utils().toastMessage(error.toString()));*/
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.black),
                fixedSize: MaterialStateProperty.resolveWith((states) => Size(MediaQuery.of(context).size.width, 50))
              ),
              child: const Text('SEND',style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
  Future _restpassword() async
  {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text.trim()).then((value){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please check your registered email"),
      ));
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Loginorg();
      }));
    });

  }
}
