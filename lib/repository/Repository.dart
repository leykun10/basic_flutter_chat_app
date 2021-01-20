import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Repository{
  FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth= FirebaseAuth.instance;
  Future<DocumentSnapshot> getUser(String userId) async{
    return firebaseFirestore.collection('users').doc(userId).get();
  }

  Future<UserCredential> createUserWithEmailAndPassword(String email,String password){
   return firebaseAuth.createUserWithEmailAndPassword(email: email,password: password);
  }
  Future<User> signIn(String email,String password){


  }

}