import 'package:flutter/material.dart';

class ProfileSliverAppBar extends StatelessWidget {
  final String _title;

  const ProfileSliverAppBar(
      this._title, {
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
/*      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.red,*/
      expandedHeight: 200,
      pinned: true,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          _title,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}