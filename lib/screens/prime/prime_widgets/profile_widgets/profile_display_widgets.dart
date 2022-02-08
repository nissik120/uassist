import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserPersonalWidget extends StatelessWidget {

  final String imagePath;
  final bool isNetwork;
  final String name;
  final String DoB;
  final String phone;
  final String postal;
  final String residence;
  final String email;

  UserPersonalWidget({
    Key key,
    this.isNetwork,
    this.imagePath,
    this.name,
    this.email,
    this.DoB,
    this.phone,
    this.postal,
    this.residence,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buildImage(imagePath, isNetwork),
            SizedBox(width: 10,),
            buildInfoDescription(),
          ],
        ),
        const Divider(
          height: 20,
          thickness: 5,
          indent: 10,
          endIndent:10,
        ),
      ],
    );
  }

  Widget buildImage(String imagePath, bool isNetwork) {
    var image;
    if(isNetwork) {
      image = imagePath.isNotEmpty ? NetworkImage(imagePath) : AssetImage(
          "assets/images/userblank.png");
    }else{
      image = imagePath.isNotEmpty ? FileImage(File(imagePath)) : AssetImage("assets/images/userblank.png");
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Material(
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );

  }

  Widget buildInfoDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(fontWeight: FontWeight.bold,),),
        SizedBox(height: 5,),
        buildInfoDescriptionItem(FontAwesomeIcons.birthdayCake, DoB),
        SizedBox(height: 5,),
        buildInfoDescriptionItem(FontAwesomeIcons.envelope, email),
        SizedBox(height: 5,),
        buildInfoDescriptionItem(FontAwesomeIcons.phoneAlt, phone),
        SizedBox(height: 5,),
        buildInfoDescriptionItem(FontAwesomeIcons.mapMarked, residence),
        SizedBox(height: 5,),
        buildInfoDescriptionItem(FontAwesomeIcons.mailBulk, postal),
      ],
    );
  }
  
  Widget buildInfoDescriptionItem(IconData rowIcon, String description){

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(
          rowIcon,
          size: 12,
        ),
        SizedBox(width: 5,),
        Flexible(
          child: new Text(description,
            style: TextStyle(fontSize: 12,),
          ),
        ),
      ],
    );
  }


}

class PersonalityExtrasWidget extends StatelessWidget {

  final String groupTag;
  final List<String> hobbies;
  final List<String> interests;
  final List<String> traits;

  const PersonalityExtrasWidget({
    Key key,
    @required this.groupTag,
    this.hobbies,
    this.interests,
    this.traits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var hobbiesText = hobbies.join(",") ?? '---';
    var interestsText = interests.join(",") ?? '---';
    var traitsText = traits.join(",") ?? '---';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          groupTag??'',
        ),
        buildExtrasItem(interestsText, 'Interests'),
        buildExtrasItem(traitsText, 'Personality and Traits'),
        buildExtrasItem(hobbiesText, 'Hobbies'),
      ],
    );
  }

  Widget buildExtrasItem(String extrasGroupList, String extrasGroupName){

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        Text(
          extrasGroupName,
          style: const TextStyle(fontSize: 10.0,),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        Text(
          extrasGroupList,
          style: const TextStyle(fontSize: 10.0),
        ),
        const Divider(
          height: 5,
          thickness: 2,
          indent: 5,
          endIndent:5,
        ),
      ],
    );
  }

}

class XPItemDetails extends StatelessWidget{

  final String title;
  final String institution;
  final String startDate;
  final String endDate;
  final String extraDetails;

  const XPItemDetails({
    Key key,
    this.title,
    this.institution,
    this.startDate,
    this.endDate,
    this.extraDetails
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            institution,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$startDate - $endDate',
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            extraDetails,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }

}