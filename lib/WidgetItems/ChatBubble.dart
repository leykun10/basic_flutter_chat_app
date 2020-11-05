import 'package:chat_app/WidgetItems/SendMessage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../WidgetItems/messageBubble.dart';
class ChatBubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseFirestore.instance.
    collection('chat').orderBy('createdAt',descending: true).snapshots(),

      builder: (context,snapStream)=>snapStream.connectionState==ConnectionState.waiting?
      Center(child: CircularProgressIndicator()):

          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ snapStream.data.docs.length<1?Center(child:Text('no chat'))
              :Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemBuilder: (ctx,index)=>
                MessageBubble(isMe:snapStream.data.docs[index].data()['userId']==FirebaseAuth.instance.currentUser.uid,
    message:snapStream.data.docs[index].data()['text'],
    userId:snapStream.data.docs[index].data()['userId'],
    key: ValueKey(snapStream.data.docs[index].id,),),
        itemCount: snapStream.data.docs.length,),
              ),
          MessageSender()
            ],
          ),);
  }
}
