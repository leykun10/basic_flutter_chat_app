import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../WidgetItems/ChatBubble.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class ChatPage extends StatefulWidget{
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  void initState() {
    final FirebaseMessaging fbm= FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (message) {
      print(message);
      return;
    },onResume: (message){
     print('ya it');
      return;
    });

   fbm.subscribeToTopic('chat');
    // TODO: implement initState
    super.initState();
  }




  @override


  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(actions: [FlatButton.icon(onPressed: () {
       FirebaseAuth.instance.signOut();
    }, icon:  Icon(Icons.exit_to_app), label: Text('log out'))],)
    ,body: ChatBubble(),);
  }
}
