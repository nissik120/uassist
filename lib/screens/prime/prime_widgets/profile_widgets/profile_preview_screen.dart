import 'package:flutter/material.dart';
import 'package:uassist/model/user.dart';
import 'package:uassist/model/user_xp.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/user_personal_widget.dart';

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
            _PersonalityExtrasWidget(
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
          itemBuilder: (context, index) =>_XPItemDetails(
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

class _XPItemDetails extends StatelessWidget{

  final String title;
  final String institution;
  final String startDate;
  final String endDate;
  final String extraDetails;

  const _XPItemDetails({
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

class _PersonalityExtrasWidget extends StatelessWidget {

  final String groupTag;
  final List<String> hobbies;
  final List<String> interests;
  final List<String> traits;

  const _PersonalityExtrasWidget({
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
        const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
        Text(
          extrasGroupName,
          style: const TextStyle(fontSize: 10.0,),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
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

