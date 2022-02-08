import 'package:flutter/material.dart';
import 'package:uassist/model/user.dart';
import 'package:uassist/model/user_xp.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/profile_display_widgets.dart';

class ProfilePreviewScreen extends StatefulWidget {

  final MyUser userInfo;

  const ProfilePreviewScreen({
    Key key,
    this.userInfo,
  }) : super(key: key);

  @override
  _ProfilePreviewScreenState createState() => _ProfilePreviewScreenState();
}

class _ProfilePreviewScreenState extends State<ProfilePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return profilePreviewWidget(widget.userInfo);
  }

  Widget profilePreviewWidget(MyUser userInfo)=> CustomScrollView(
    slivers: [
      SliverList(
        delegate: SliverChildListDelegate(
          [
            UserPersonalWidget(
              isNetwork: true,
              imagePath: userInfo.imagePath,
              name: '${userInfo.firstName} ${userInfo.lastName}',
              email: userInfo.email,
              DoB: userInfo.dateOfBirth,
              phone: userInfo.phoneNumber,
              residence: userInfo.residenceAddress,
              postal: userInfo.postalAddress,
            ),
            buildXPGroup(context, "Education", userInfo.education,),
            buildXPGroup(context, "Experience", userInfo.work,),
            PersonalityExtrasWidget(
              groupTag: "Interests and Skills",
              interests: userInfo.interests,
              traits: userInfo.traits,
              hobbies: userInfo.hobbies,
            ),
          ],
        ),
      ),
    ],
  );


  Widget buildXPGroup(BuildContext context, String groupName, List<UserXP> groupItems){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          groupName,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: groupItems.length,
          itemBuilder: (context, index) => XPItemDetails(
            title: groupItems[index].title,
            institution: groupItems[index].institution,
            startDate: groupItems[index].startDate,
            endDate: groupItems[index].endDate,
            extraDetails: groupItems[index].extraDetails,
          ),
        ),
        const Divider(
          height: 10,
          thickness: 2,
          indent: 10,
          endIndent:10,
        ),
      ],
    );
  }



}

