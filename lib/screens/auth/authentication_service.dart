import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uassist/screens/auth/sign_in_page.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future signOut() async{
    var result =  FirebaseAuth.instance.signOut();
    //notifyListeners();
    return result;
  }

  Future signIn({String email, String password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    }on FirebaseAuthException catch(e){
      return e.message;
    }

  }

  Future signUp({BuildContext context, String email, String password}) async{
    try{
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(user!=null){
        print("User Registered");
      }
      return null;
    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }


}