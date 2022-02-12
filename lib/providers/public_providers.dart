import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uassist/model/institution.dart';

class InstitutionProvider extends ChangeNotifier{

  final database = FirebaseDatabase.instance.ref("institutions");
  List<Institution> _institutionList = [];

  List<Institution> getInstitutionList(){
    return _institutionList;
  }

  void setInstitutionList(List<Institution> institutionList){
    _institutionList = institutionList;
    notifyListeners();
  }

  Future<bool> readInstitutions() async {
    DatabaseEvent event = await database.once();
    if(event.snapshot.value!=null) {
      final List data = jsonDecode(jsonEncode(event.snapshot.value));
      final List<Institution> institutionList = InstitutionList
          .fromJson(data)
          .institutions;
      setInstitutionList(institutionList);
    }
    return event.snapshot.value!=null;
  }

}