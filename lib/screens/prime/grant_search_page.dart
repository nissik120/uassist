import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uassist/model/grant.dart';
import 'package:uassist/screens/prime/prime_widgets/prime_widgets_headers.dart';
import 'package:uassist/screens/prime/prime_widgets/search_widget.dart';

class GrantSearchPage extends StatefulWidget {
  //const GrantSearchPage({Key? key}) : super(key: key);

  @override
  _GrantSearchPageState createState() => _GrantSearchPageState();
}

class _GrantSearchPageState extends State<GrantSearchPage> {
  final database = FirebaseDatabase.instance.ref("grants");
  final String appbarTitle = "Grant Search";
  String query = '';
  List<Grant> grantList = [];
  List<Grant> filteredGrantList = [];

  Future<void> parseJson() async {
    DatabaseEvent event = await database.once();
    final List data = jsonDecode(jsonEncode(event.snapshot.value));
    final List<Grant> _grantList = data.map((i) => Grant.fromJson(i)).toList();
    setState(() {
      grantList = _grantList;
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
              Text('${filteredGrantList.length} Results Found'),
              grantList.isNotEmpty ?
              buildGrantList(context, filteredGrantList)
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
    hintText: 'Grant Name or Type',
    onChanged: filterGrant,
  );

  Widget buildGrantList(BuildContext context, List<Grant> listOfGrants){
    return Flexible(
      child: ListView.separated(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        itemCount: listOfGrants.length,
        itemBuilder: (context, index){
          return buildGrant(listOfGrants[index]);
        },
        separatorBuilder: (context, index){
          return Divider();
        },
      ),
    );
  }

    Widget buildGrant(Grant grant)=>Card(
    elevation: 0,
    child: InkWell(
      onTap: (){},
      child: ListTile(
        title: Wrap(
          children: [
            Text(grant.grantHeading),
          ],
        ),
        subtitle: Wrap(
          children: [
            Text('MWK${grant.grantFinance.grantAmount}'),
            Text(''),
          ],
        ),
      ),
    ),
  );

  void filterGrant(String query){
    final filteredGrantList =  grantList.where((grant){
      final queryLower = query.toLowerCase();
      final grantNameLower = grant.grantHeading.toLowerCase();

      return grantNameLower.contains(queryLower);

    }).toList();

    setState(() {
      this.query = query;
      this.filteredGrantList = filteredGrantList;
    });

  }

}
