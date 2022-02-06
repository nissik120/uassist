import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uassist/model/institution.dart';
import 'package:uassist/screens/prime/prime_widgets/prime_widgets_headers.dart';
import 'package:uassist/screens/prime/prime_widgets/search_widget.dart';

class InstituteSearchPage extends StatefulWidget {
  //const InstituteSearchPage({Key? key}) : super(key: key);

  @override
  _InstituteSearchPageState createState() => _InstituteSearchPageState();
}

class _InstituteSearchPageState extends State<InstituteSearchPage> {
  final database = FirebaseDatabase.instance.ref("institutions");
  final String appbarTitle = "Tertiary Institute Search";
  String query = '';
  List<Institution> institutionList = [];
  List<Institution> filteredInstituteList = [];

  Future<void> parseJson() async {
    DatabaseEvent event = await database.once();
    final List data = jsonDecode(jsonEncode(event.snapshot.value));
    final List<Institution> _institutionList =  InstitutionList.fromJson(data).institutions;
    setState(() {
      institutionList = _institutionList;
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
              Text('${filteredInstituteList.length} Results Found'),
              institutionList.isNotEmpty ?
              buildInstitutionList(context, filteredInstituteList)
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
    hintText: 'Institution or Study Field',
    onChanged: filterInstitute,
  );

  Widget buildInstitutionList(BuildContext context, List<Institution> listOfInstitutions){
    return Flexible(
      child: ListView.separated(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        itemCount: listOfInstitutions.length,
        itemBuilder: (context, index){
          return buildInstitution(listOfInstitutions[index]);
        },
        separatorBuilder: (context, index){
          return Divider();
        },
      ),
    );
  }

  Widget buildInstitution(Institution institution)=>Card(
    elevation: 0,
    child: InkWell(
      onTap: (){},
      child: ListTile(
        title: Wrap(
          children: [
            Text(institution.institutionName),
          ],
        ),
        subtitle: Wrap(
          children: [
            Text('${institution.contactInfo.city}, ${institution.contactInfo.country}'),
            Text(''),
          ],
        ),
      ),
    ),
  );

  void filterInstitute(String query){
    final filteredInstituteList =  institutionList.where((institution){
      final queryLower = query.toLowerCase();
      final institutionNameLower = institution.institutionName.toLowerCase();
      var institutionFields = institution.instituteSpecializations;

      return institutionNameLower.contains(queryLower);

    }).toList();

    setState(() {
      this.query = query;
      this.filteredInstituteList = filteredInstituteList;
    });

  }

}
