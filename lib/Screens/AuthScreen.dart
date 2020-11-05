import 'package:chat_app/WidgetItems/AuthForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../Provider/AnimationNotifier.dart';
import '../WidgetItems/Logo.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(
      alignment: Alignment.topLeft,
      children: [

        Container(
                child: ChangeNotifierProvider(
                  create: (context)=>AnimationNotifier(),
                  child: Column(
                    children: [
                     Logo(),
                      SizedBox(height: 10,),
                      Expanded(child: AuthForm()),

                    ],
                  ),
                ),


                decoration: BoxDecoration(gradient:
              LinearGradient(list: [Colors.purpleAccent[100],Colors.pinkAccent[100]],begin: Alignment.centerLeft,
                  end: Alignment.centerRight,stops: [0.0,1]),),),

   ],
    ),);
  }
}
