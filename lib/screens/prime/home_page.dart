import 'package:flutter/material.dart';
import 'package:uassist/screens/prime/prime_widgets/custom_bottom_bar.dart';
import 'package:uassist/screens/prime/prime_widgets/dashboard_screen.dart';
import 'package:uassist/screens/prime/prime_widgets/notifications_screen.dart';
import 'package:uassist/screens/prime/prime_widgets/settings_screen.dart';
import 'package:uassist/screens/prime/prime_widgets/user_profile_screen.dart';
import 'package:uassist/screens/prime/prime_widgets/user_profile_tab_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedItemIndex = 0;

  List<Widget> homeScreenList = [
    Dashboard(),
    SettingsScreen(),
    NotificationsScreen(),
    UserProfileTabScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SafeArea(
        child: homeScreenList[_selectedItemIndex],
      ),
      bottomNavigationBar: myCustomBottomBar(),
    );
  }

  Widget myCustomBottomBar(){

    return Container(
      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: const BorderRadius.all(const Radius.circular(50.0)),
        boxShadow: [
          BoxShadow(
            //color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(0,0), // shadow direction: bottom right
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.settings, 1),
          buildNavBarItem(Icons.notifications, 2),
          buildNavBarItem(Icons.person, 3),
        ],
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index){
    return IconButton(
        icon: Icon(
          icon,
          color: index == _selectedItemIndex ? Colors.white : Colors.grey,
        ),
        onPressed: (){
          setState(() {
            _selectedItemIndex = index;
          });
        },
    );
  }


}