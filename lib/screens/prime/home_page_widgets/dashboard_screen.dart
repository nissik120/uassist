import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uassist/screens/prime/career_guide_page.dart';
import 'package:uassist/screens/prime/grant_search_page.dart';
import 'package:uassist/screens/prime/institute_search_page.dart';
import 'package:uassist/screens/prime/mentor_program_page.dart';
import 'package:uassist/screens/general/dashboard_data.dart';
import 'package:uassist/screens/general/prime_widgets_headers.dart';
import 'package:uassist/screens/prime/study_partner_page.dart';
import 'package:uassist/screens/prime/vacancies_page.dart';

List<Widget> DashboardPageList = [
  InstituteSearchPage(),
  GrantSearchPage(),
  CareerGuidePage(),
  StudyPartnerPage(),
  MentorProgramPage(),
  VacanciesPage(),
];

class Dashboard extends StatefulWidget {
  //const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var dashData = DashboardData.getData;
  final String pageTitle = 'Explore Our \nServices';

  @override
  Widget build(BuildContext context) {

    final homeCardGrid = Container(
      height: MediaQuery.of(context).size.height,
      child: GridView.count(
        childAspectRatio: (1 / .8),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(10),
        primary: true,
        crossAxisCount: 2,
        children: List.generate(dashData.length, (index) => Container(
          child: Card(
            //color: Colors.white,
            elevation: 25,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>DashboardPageList[index]
                    ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(
                      dashData[index]['icon'],
                      color: Colors.orange,
                      size: 24.0,
                    ),
                    SizedBox(height: 5,),
                    Text(
                      dashData[index]['name'],
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ),
      ),
    );


    return SingleChildScrollView(
          child: Column(
            children: [
              PrimeWidgetsHeaders(pageTitle),
              homeCardGrid,
            ],
          ),
    );
  }
}
