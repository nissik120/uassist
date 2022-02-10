import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uassist/model/user.dart';

class UserIntroProvider extends ChangeNotifier{
  User firebaseUser;
  MyUser _myCurrentUser;
  final databaseRef = FirebaseDatabase.instance.ref("users");

  UserIntroProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser;
    _myCurrentUser = MyUser.createEmpty();
  }

  MyUser getUser(){
    return _myCurrentUser;
  }

  void setUser(MyUser myUser){
    _myCurrentUser = myUser;
    notifyListeners();
  }

  void updateDatabase() async{
    if(firebaseUser!=null) {
      final data = getUser().toMap();
      //final jsonData = json.encode(data);
      databaseRef.child(firebaseUser.uid)
          .set(data)
          .then((value) => print('Write successful'))
          .catchError((error) {
        print(error);
      });
    }
  }

  Future<bool> readDatabase() async{

    if(firebaseUser!=null){
      DatabaseEvent userEvent = await databaseRef.child(firebaseUser.uid).once();
      if(userEvent.snapshot.value !=null){
        final data = jsonDecode(jsonEncode(userEvent.snapshot.value));
        final MyUser userInfoJson = MyUser.fromJson(data);
        setUser(userInfoJson);
      }
      return userEvent.snapshot.value !=null;
    }
    return false;

  }


}