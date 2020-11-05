import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MessageSender extends StatefulWidget {
  @override
  _MessageSenderState createState() => _MessageSenderState();
}

class _MessageSenderState extends State<MessageSender> {
  TextEditingController message;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    message=TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    message.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.only(bottom: 5,left: 10),
      child: Row(children: [
        Expanded(

            child: TextField(
              controller: message,
              decoration: InputDecoration(labelText: 'write a message'),
            )),IconButton(icon: Icon(Icons.send),onPressed: () {
          FirebaseFirestore.instance.collection ('chat').add({'text':message.text,
          'createdAt':Timestamp.now(),
          'userId':FirebaseAuth.instance.currentUser.uid});
          FocusScope.of(context).unfocus();
        }
          ,)
      ],),
    );
  }
}
