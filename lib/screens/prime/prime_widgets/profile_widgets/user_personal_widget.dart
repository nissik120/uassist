import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserPersonalWidget extends StatelessWidget {

  final String imagePath;
  final String name;
  final String DoB;
  final String phone;
  final String postal;
  final String residence;
  final String email;

  UserPersonalWidget({
    Key key,
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
            buildImage(),
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

  Widget buildImage() {
    final image = NetworkImage(imagePath);

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