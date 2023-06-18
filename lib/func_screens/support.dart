import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
class Support extends StatefulWidget {
  const Support({Key? key,required this.email,required this.username}) : super(key: key);
final String? email;
final String? username;
  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text("Chat Support"),
      ),
      body: Tawk(
          directChatLink: 'https://tawk.to/chat/6456308ead80445890eb70dd/1gvoarbhv',
        visitor: TawkVisitor(
          name:widget.username.toString(),
          email:widget.email.toString()
        ),
        onLoad:(){print("Hello");},
        placeholder: Center(
          child: Text("Loading"),
        ),
        onLinkTap: (String url) {
          print(url);
        },
      ),
    );
  }
}
