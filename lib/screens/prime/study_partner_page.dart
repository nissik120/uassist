import 'package:flutter/material.dart';
import 'package:uassist/screens/prime/prime_widgets/prime_widgets_headers.dart';

class StudyPartnerPage extends StatefulWidget {
  //const StudyPartnerPage({Key? key}) : super(key: key);

  @override
  _StudyPartnerPageState createState() => _StudyPartnerPageState();
}

class _StudyPartnerPageState extends State<StudyPartnerPage> {
  final String appbarTitle = "Study Better With Us";

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
