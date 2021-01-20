import 'dart:io';
import 'package:chat_app/WidgetItems/Imageselector.dart';
import 'package:chat_app/repository/Repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Provider/AnimationNotifier.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FormItem extends StatefulWidget {
  @override
  _FormItemState createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  final _formKey = GlobalKey<FormState>();

   TextEditingController passwordController;
  TextEditingController emailController;
  TextEditingController usernameController;

  @override
  void initState() {
    passwordController=TextEditingController();
    emailController=TextEditingController();
    usernameController=TextEditingController();
    emailController.addListener(() {
      Provider.of<AnimationNotifier>(context,listen: false).createMotion();
    });
    passwordController.addListener(() {
     Provider.of<AnimationNotifier>(context,listen: false).createMotion();
    });
    usernameController.addListener(() {
      Provider.of<AnimationNotifier>(context,listen: false).createMotion();
    });
    // TODO: implement initState
    super.initState();
  }
   @override
  void dispose() {

    // TODO: implement dispose
   passwordController.dispose();
   emailController.dispose();
   usernameController.dispose();
     super.dispose();
  }
  bool isSignup=false;
  bool isLoading=false;
  UserCredential userData;
  File userImage;
void setUserImage(File image){
  userImage=image;
}
void tryLogin() async{
  final valid=_formKey.currentState.validate();
  FocusScope.of(context).unfocus();
  if(valid){
    try{
      if(isSignup  ){ setState(() {
        isLoading=!isLoading;
      });
      if(userImage!=null){ userData= await Repository()
          .createUserWithEmailAndPassword(emailController.text,passwordController.text);
      print(userData.user.displayName);
      userData.user.updateProfile(displayName:'leykun',photoURL: '');
      StorageReference ref= FirebaseStorage.instance.ref().child('userImage').child(FirebaseAuth.instance.currentUser.uid+'jpg');
       await   ref.putFile(userImage,).onComplete;
       dynamic url =await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(userData.user.uid).
      set({'username': usernameController.text,
        'email':emailController.text,
      'imageUrl':url});}
      else {
        isLoading=!isLoading;
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('select an image'),));
      }
       

      }
      else
      {   setState(() {
        isLoading=!isLoading;
      });
        userData = await FirebaseAuth.instance.signInWithEmailAndPassword
          (email: emailController.text, password: passwordController.text);
          print(FirebaseAuth.instance.currentUser.displayName);
      }
    } on PlatformException catch(error){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("error occurred"),));
      setState(() {
        isLoading=!isLoading;
      });
    } catch(error){
      setState(() {
        isLoading=!isLoading;
      });
               print(' ');
    }


  }
}
  @override
  Widget build(BuildContext context) {

    return  Form(
      key: _formKey,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.fromLTRB(40, 0, 20, 0),
        child: Container(
          child: Column(children: [
           if(isSignup)ImageProfile(setUserImage),
            SizedBox(height: 30,),
            TextFormField(
              validator: (value){

                if(value.isEmpty || !value.contains('@')){
                  return 'please enter a valid email address';
                }
                return null;
              },
              controller: emailController,
              onEditingComplete: (){
                Provider.of<AnimationNotifier>(context,listen: false).stopMotion();
              },
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  hoverColor: Colors.white,
                  fillColor:Colors.deepPurple,
                  filled: true,
                  prefixIcon: Icon(Icons.email,color: Colors.black,),
                  hintText:'email address',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),),
            SizedBox(height: 20,),
            if(isSignup)
              TextFormField(
                  controller: usernameController,
                onEditingComplete: (){
                  Provider.of<AnimationNotifier>(context,listen: false).stopMotion();
                },
                validator: (value){
                  if(value.isEmpty){
                    return 'please enter a valid username';
                  }
                  return null;
                },

                cursorColor: Colors.black,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    hoverColor: Colors.white,
                    fillColor:Colors.deepPurple,
                    filled: true,
                    prefixIcon: Icon(Icons.supervised_user_circle,color: Colors.black,),
                    hintText:'username',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)))
                ,),
              SizedBox(height: 20,),
            TextFormField(
              validator: (value){
                if(value.isEmpty || value.length<7){
                  return 'password is too short';
                }
                return null;
                },
              onEditingComplete: (){

                Provider.of<AnimationNotifier>(context,listen: false).stopMotion();
              },
              controller: passwordController,
              obscureText: true,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  fillColor:Colors.deepPurple,
                  filled: true,
                  suffixIcon: InkWell(child: Icon(Icons.remove_red_eye,color: Colors.black,),onTap:(){
                  },),
                  prefixIcon: Icon(Icons.vpn_key,color: Colors.black,),
                  hintText:'password',
                  border: OutlineInputBorder(borderRadius:
                  BorderRadius.circular(30))),),

            SizedBox(height: 20,),
            isLoading?CircularProgressIndicator()
              :FlatButton(
              padding: EdgeInsets.only(top: 15,bottom: 15),
              onPressed: (){
                  tryLogin();
              },child: Container(width: 160,child:isSignup? Text('Sign Up',style:
            TextStyle(color: Colors.white,fontSize: 17),textAlign: TextAlign.center,):
            Text('Log In',style: TextStyle(color: Colors.white,fontSize: 17),textAlign: TextAlign.center,)),shape:
            RoundedRectangleBorder(borderRadius:
            BorderRadius.circular(29),),color: Colors.pink,)
    ,
            SizedBox(height: 10,),

    if(!isLoading)
      Container(
        width: double.infinity,
        child: Row(

                mainAxisAlignment: MainAxisAlignment.center,children: [

                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FlatButton(
                        onPressed: (){
                          setState(() {
                            isSignup=!isSignup;
                          });
                        },
                        child: Row(
                          children: [
                            isSignup?
                            Text('I ALREADY HAVE AN ACCOUNT',style: TextStyle(fontWeight:
                            FontWeight.bold,fontSize:18,color: Colors.black),)
                                :Text('CREATE ACCOUNT',style: TextStyle(fontWeight:
                            FontWeight.bold,fontSize:18,color: Colors.black),),
                            Icon(Icons.lock_open)
                          ],
                        ),),
                    ),
                  ],
                )
              ],),
      )],),
        ),
      ),);
  }
}
