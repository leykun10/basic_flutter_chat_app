import 'package:chat_app/repository/Repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MessageBubble extends StatelessWidget {
  final String message;
  final String userId;
  final bool isMe;
  final Key key;
  MessageBubble({this.isMe,this.message,this.userId,this.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,

        children: [

          Container(

            child: FutureBuilder(
              future: Repository().getUser(userId),

              builder: (context, snapshot) {

                return snapshot.hasData? Stack(

                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        decoration: BoxDecoration(
                            gradient: isMe?LinearGradient(colors: [Colors.blueAccent,Colors.indigo])
                                :LinearGradient(colors: [Colors.purple,Colors.purpleAccent]),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                              topLeft: Radius.circular(10,),bottomRight: Radius.circular(10),
                            )),
                      child: Column(
                        children: [
                          Text(snapshot.data.data()['username']),
                          Text(message,style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                  Positioned(top: -20,
                    right:isMe?0:120,


                    child: CircleAvatar(backgroundImage: NetworkImage(snapshot.data.data()['imageUrl']),),)],overflow: Overflow.visible,
                ):Center(child: Text('loading...'),);
              }
            ),
           ),
        ],
      ),
    );
  }
}
