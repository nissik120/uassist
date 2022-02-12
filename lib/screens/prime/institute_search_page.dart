import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uassist/model/institution.dart';
import 'package:uassist/providers/public_providers.dart';
import 'package:uassist/screens/general/empty_state_widget.dart';
import 'package:uassist/screens/general/prime_widgets_headers.dart';
import 'package:uassist/screens/general/search_widget.dart';
import 'package:uassist/screens/prime/institute_page_widgets/institute_brief_screen.dart';

class InstituteSearchPage extends StatefulWidget {
  //const InstituteSearchPage({Key? key}) : super(key: key);

  @override
  _InstituteSearchPageState createState() => _InstituteSearchPageState();
}

class _InstituteSearchPageState extends State<InstituteSearchPage> {

  final database = FirebaseDatabase.instance.ref("institutions");
  final String appbarTitle = "Tertiary Institute Search";
  String query = '';
  bool isDataAvailable = false;

  List<Institution> institutionList = [];
  List<Institution> filteredInstituteList = [];

  void readInstitutionsData() {
    final institutionProvider = Provider.of<InstitutionProvider>(context);
    institutionProvider.readInstitutions()
        .then(
            (value){
              setState(() {
                isDataAvailable = value;
              });

              if(value){
                setState(() {
                  institutionList = institutionProvider.getInstitutionList();
                  filterInstitute(query);
                });
              }
            });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    readInstitutionsData();

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
              institutionList.isNotEmpty | isDataAvailable ?
              buildInstitutionList(context, filteredInstituteList)
                  : EmptyStateWidget(
                message: 'Failed to display content',
                onPressed: readInstitutionsData,
              ),
            ],
          ),
        ),
      ),
    );
  }

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
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)=>InstituteBriefScreen(institution: institution,),
          ),
        );
      },
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
