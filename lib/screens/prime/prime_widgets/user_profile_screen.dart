import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:uassist/model/user.dart';
import 'package:uassist/model/user_xp.dart';
import 'package:uassist/screens/prime/prime_widgets/prime_widgets_headers.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/profile_edit_screen.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/profile_preview_screen.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/user_personal_widget.dart';

Future<String> readJson() {
  return rootBundle.loadString('assets/user.json');
}

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();

}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final database = FirebaseDatabase.instance.ref("users");
  final String pageTitle = 'Tell us and others about you\n';
  bool isUserExisting = true;
  bool isPreviewMode = true;
  List _userItems = [];
  MyUser userInfo = new MyUser();


  @override
  void initState() {
    super.initState();
    User currentUser = FirebaseAuth.instance.currentUser;
    isExistingUser(currentUser.uid).then((value) =>
        setState((){
          isUserExisting = value;
        })
    );
  }

  Future<bool> isExistingUser(String userId) async{
    DatabaseEvent userEvent = await database.child(userId).once();
    if(userEvent.snapshot.value !=null){
      final data = jsonDecode(jsonEncode(userEvent.snapshot.value));
      final MyUser _userInfoJson = MyUser.fromJson(data);
      print(_userInfoJson);
      setState(() {
        userInfo = _userInfoJson;
      });
    }
    return userEvent.snapshot.value !=null;
  }

  Future<void> parseJson() async {
    String jsonString = await readJson();
    final response = jsonDecode(jsonString);
    setState(() {
      _userItems = response;
    });
  }

  void toggleViewMode(){
    setState(() {
      isPreviewMode = !isPreviewMode;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: PrimeWidgetsHeaders(pageTitle),
        ),
        isUserExisting?
        baseCard(context, userInfo)
        : contentFailState(),
      ],
    );
  }

  Widget contentFailState() => Container(
    margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 100.0),
    child: Center(
      child: Column(
        children: [
          Text('Failed to display content'),
          TextButton(
            onPressed: ()=>parseJson(),
            child: Text('Refresh'),
          ),
        ],
      ),
    ),
  );

  //BASE LAYOUT WIDGETS

  Widget baseCard(BuildContext context, MyUser userInfo) => Card(
    elevation: 20.0,
    //color: Colors.white,
    margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 60.0),
    child: Padding(
      padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 18.0, bottom: 5.0),
      child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: (){toggleViewMode();},
              child: Text(
                  isPreviewMode ? 'Edit Profile' : 'Close Edit'
              ),
            ),
          ],
        ),
        Expanded(
          child: isPreviewMode ? ProfilePreviewScreen(userInfo: userInfo) : ProfileEditScreen(userInfo: userInfo),
        ),

      ],
    ),
    ),
  );


}
