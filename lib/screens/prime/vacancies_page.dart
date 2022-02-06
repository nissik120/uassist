import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uassist/model/vacancies.dart';
import 'package:uassist/screens/prime/prime_widgets/prime_widgets_headers.dart';
import 'package:uassist/screens/prime/prime_widgets/search_widget.dart';

Future<String> readJson() {
  return rootBundle.loadString('assets/grants.json');
}

class VacanciesPage extends StatefulWidget {
  //const VacanciesPage({Key? key}) : super(key: key);

  @override
  _VacanciesPageState createState() => _VacanciesPageState();
}

class _VacanciesPageState extends State<VacanciesPage> {
  final database = FirebaseDatabase.instance.ref("vacancies");
  final String appbarTitle = "Our Vacancies";
  String query = '';
  List<Vacancies> vacanciesList = [];
  List<Vacancies> filteredVacanciesList = [];

  Future<void> parseJson() async {
    DatabaseEvent event = await database.once();
    final List data = jsonDecode(jsonEncode(event.snapshot.value));
    final List<Vacancies> _vacanciesList = data.map((i) => Vacancies.fromJson(i)).toList();
    setState(() {
      vacanciesList = _vacanciesList;
    });

  }

  @override
  void initState() {
    super.initState();

    parseJson();

  }

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
              buildSearch(),
              SizedBox(height: 25,),
              Text('${filteredVacanciesList.length} Results Found'),
              vacanciesList.isNotEmpty ?
              buildVacanciesList(context, filteredVacanciesList)
                  : contentFailState(),
            ],
          ),
        ),
      ),
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

  Widget buildSearch()=>SearchWidget(
    text: query,
    hintText: 'Job Title or Company Name',
    onChanged: filterVacancies,
  );

  Widget buildVacanciesList(BuildContext context, List<Vacancies> listOfVacancies){
    return Flexible(
      child: ListView.separated(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        itemCount: listOfVacancies.length,
        itemBuilder: (context, index){
          return buildVacancies(listOfVacancies[index]);
        },
        separatorBuilder: (context, index){
          return Divider();
        },
      ),
    );
  }

  Widget buildVacancies(Vacancies vacancies)=>Card(
    elevation: 0,
    child: InkWell(
      onTap: (){},
      child: ListTile(
        title: Wrap(
          children: [
            Text(vacancies.jobTitle),
          ],
        ),
        subtitle: Wrap(
          children: [
            Text(vacancies.company),
            Text(vacancies.datePosted),
          ],
        ),
      ),
    ),
  );

  void filterVacancies(String query){
    final filteredVacanciesList =  vacanciesList.where((vacancies){
      final queryLower = query.toLowerCase();
      final jobNameLower = vacancies.jobTitle.toLowerCase();
      final companyNameLower = vacancies.company.toLowerCase();

      return jobNameLower.contains(queryLower) || companyNameLower.contains(queryLower);

    }).toList();

    setState(() {
      this.query = query;
      this.filteredVacanciesList = filteredVacanciesList;
    });

  }

}
