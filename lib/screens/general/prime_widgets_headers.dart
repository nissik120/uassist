import 'package:flutter/material.dart';

class PrimeWidgetsHeaders extends StatelessWidget with PreferredSizeWidget{

  final String title;

  const PrimeWidgetsHeaders(
      this.title,
      {Key key,}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      backgroundColor: Colors.black,
      automaticallyImplyLeading: true,
    );
  }

  Widget customHeader() => Container(
    padding: EdgeInsets.fromLTRB(10, 20, 10, 30),
    decoration: BoxDecoration(
      color: Colors.black,
    ),
    child: Row(
      children: [
        Text(
            'Explore Our \nServices',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
      ],
    ),
  );

  @override
  Size get preferredSize => Size.fromHeight(50.0);

}
