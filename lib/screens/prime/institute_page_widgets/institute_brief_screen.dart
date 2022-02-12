import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uassist/model/institution.dart';
import 'package:uassist/screens/general/icon_description_row_widget.dart';
import 'package:uassist/screens/general/prime_widgets_headers.dart';
import 'package:uassist/screens/general/specialization_data.dart';

class InstituteBriefScreen extends StatelessWidget {

  final Institution institution;

  const InstituteBriefScreen({Key key, this.institution}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String screenTitle = "Institute Details";

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimeWidgetsHeaders(screenTitle),
              InstituteHeaderWidget(
                instituteName: institution.institutionName,
                instituteCity: institution.contactInfo.city,
                instituteCountry: institution.contactInfo.country,
                onPressed: ()=> showModalBottomSheet(
                  context: context,


                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context)=>buildSheet(),
                ),
              ),
              const SizedBox(height: 4,),
              InstituteStatusWidget(
                instituteAccreditation: institution.instituteStatus.isAccredited,
                instituteRank: institution.instituteStatus.countryRank,
                instituteOwnership: institution.instituteStatus.isPublicOwned ? 'Yes':'No',
                instituteAddress: institution.contactInfo.postalAddress,
                institutePhoneNumber: institution.contactInfo.phoneNumber,
                instituteWebsite: institution.institutionWebsite,
                instituteYearOpened: institution.instituteStatus.foundedYear,
              ),
              const SizedBox(height: 10,),
              InstituteSpecializationWidget(instituteSpecializationsList: institution.instituteSpecializations,),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSheet()=> DraggableScrollableSheet(
    initialChildSize: 1,
    minChildSize: 0.9,
    maxChildSize: 1,
    builder: (_, controller)=>Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
  );

}

class InstituteHeaderWidget extends StatelessWidget {

  final String instituteName;
  final String instituteCity;
  final String instituteCountry;

  final VoidCallback onPressed;

  const InstituteHeaderWidget({Key key, this.onPressed, this.instituteName, this.instituteCity, this.instituteCountry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: FaIcon(FontAwesomeIcons.university),
            title: Wrap(
              children: [
                Text(instituteName),
              ],
            ),
            subtitle: Wrap(
              children: [
                Text('$instituteCity, $instituteCountry'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (){},
                child: Text('Visit Website'),
              ),
              const SizedBox(width: 30,),
              ElevatedButton(
                onPressed: onPressed,
                child: Text('View Programmes'),
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
}

class InstituteStatusWidget extends StatelessWidget {
  final String instituteAddress;
  final String instituteWebsite;
  final String institutePhoneNumber;
  final String instituteAccreditation;
  final String instituteOwnership;
  final int instituteRank;

  final int instituteYearOpened;

  const InstituteStatusWidget({Key key, this.instituteYearOpened, this.instituteAddress, this.instituteWebsite, this.institutePhoneNumber, this.instituteAccreditation, this.instituteOwnership, this.instituteRank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildStatusRow(),
          SizedBox(height: 20,),
          IconDescriptionRowWidget(rowIcon: FontAwesomeIcons.locationArrow, description: instituteAddress),
          SizedBox(height: 10,),
          IconDescriptionRowWidget(rowIcon: FontAwesomeIcons.globe, description: instituteWebsite),
          SizedBox(height: 10,),
          IconDescriptionRowWidget(rowIcon: FontAwesomeIcons.phoneAlt, description: institutePhoneNumber)
        ],
      ),
      ),
    );
  }

  Widget buildStatusRow(){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Established', style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            Text('$instituteYearOpened'),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Accredited', style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            Text(instituteAccreditation),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Public', style: TextStyle(fontWeight: FontWeight.bold),),
            Text(instituteOwnership),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Rank', style: TextStyle(fontWeight: FontWeight.bold),),
            Text('$instituteRank'),
          ],
        ),
      ],
    );
  }

}

class InstituteSpecializationWidget extends StatelessWidget {

  final List<String> instituteSpecializationsList;


  const InstituteSpecializationWidget({Key key, this.instituteSpecializationsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            padding: EdgeInsets.all(5),
            crossAxisSpacing: 20,
            children: instituteSpecializationsList.map((item){
              IconData myIcon = SpecializationData.specializationMap[item.toLowerCase()];
              return buildGridItem(myIcon, item);
            }).toList(growable: false),
          ),
    );
  }

  Widget buildGridItem(IconData icon, String topic){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FaIcon(icon ?? FontAwesomeIcons.graduationCap, color: Colors.deepOrange,),
        const SizedBox(height: 10,),
        Flexible(
          child: Text('$topic', textAlign: TextAlign.center,),
        ),
      ],
    );
  }

}



