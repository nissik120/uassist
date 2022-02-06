import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uassist/model/user.dart';

class UserIntroProvider extends ChangeNotifier{
  MyUser _myCurrentUser;
  final databaseRef = FirebaseDatabase.instance.ref("users");

  UserIntroProvider(){
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
    User currentUser = FirebaseAuth.instance.currentUser;
    final data = getUser().toMap();
    final jsonData = json.encode(data);
    databaseRef.child(currentUser.uid)
        .set(data)
        .then((value) => print('Write successful'))
        .catchError((error){
          print(error);
        });
  }

}