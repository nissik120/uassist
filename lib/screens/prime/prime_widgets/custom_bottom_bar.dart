import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {

  //const CustomBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: const BorderRadius.all(const Radius.circular(50.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(0,0), // shadow direction: bottom right
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(icon: Icon(Icons.home), onPressed: (){}),
          IconButton(icon: Icon(Icons.settings), onPressed: (){}),
          IconButton(icon: Icon(Icons.notifications), onPressed: (){}),
          IconButton(icon: Icon(Icons.person), onPressed: (){}),
        ],
      ),
    );
  }
}
