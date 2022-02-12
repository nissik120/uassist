import 'package:flutter/material.dart';
import 'package:uassist/screens/general/prime_widgets_headers.dart';

class MentorProgramPage extends StatefulWidget {
  //const MentorProgramPage({Key? key}) : super(key: key);

  @override
  _MentorProgramPageState createState() => _MentorProgramPageState();
}

class _MentorProgramPageState extends State<MentorProgramPage> {
  final String appbarTitle = "Our Mentorship Programme";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimeWidgetsHeaders(appbarTitle),
              SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}
