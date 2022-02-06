import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuple/tuple.dart';
import 'package:uassist/delegates/sliver_persistent_header_delegate_impl.dart';
import 'package:uassist/model/user.dart';
import 'package:uassist/model/user_xp.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/editlistfield_widget.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/profile_sliver_app_bar.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/textfield_widget.dart';

class ProfileEditScreen extends StatefulWidget {
  final MyUser userInfo;

  const ProfileEditScreen({
    Key key,
    this.userInfo,
  }) : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> with SingleTickerProviderStateMixin {
  
  TabController _tabController;
  MyUser userInfo;

  List<Tuple3> _sections;


  @override
  void initState() {
    super.initState();
    userInfo = widget.userInfo;
    _sections = [
      Tuple3("Personal", PersonalProfileSection(userInfo: userInfo,), FaIcon(FontAwesomeIcons.userAlt, size: 12,)),
      Tuple3("Education", EducationProfileSection(userInfo: userInfo,), FaIcon(FontAwesomeIcons.graduationCap, size: 12,)),
      Tuple3("Experience", WorkProfileSection(userInfo: userInfo,), FaIcon(FontAwesomeIcons.briefcase, size: 12,)),
      Tuple3("Other Details", ExtrasProfileSection(userInfo: userInfo,), FaIcon(FontAwesomeIcons.listAlt, size: 12,)),
    ];
    _tabController = TabController(length: _sections.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
        return <Widget>[
          //ProfileSliverAppBar(_sections[_tabController.index].item1),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverPersistentHeaderDelegateImpl(
              tabBar: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                controller: _tabController,
                tabs: _sections
                    .map<Tab>((Tuple3 page) => Tab(icon: page.item3))
                    .toList(),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: _sections.map<Widget>((Tuple3 section) => section.item2).toList(),
      ),

    );

  }

}

class PersonalProfileSection extends StatelessWidget{

  final MyUser userInfo;

  const PersonalProfileSection({
    Key key,
    this.userInfo,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        SizedBox(height: 10,),
        ProfileWidget(
          imagePath: userInfo.imagePath,
          onClicked: () async {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'First Name(s)',
          text: userInfo.firstName,
          onChanged: (firstName) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Last Name',
          text: userInfo.lastName,
          onChanged: (lastName) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Date of Birth (yyyy.mm.dd)',
          text: userInfo.dateOfBirth,
          onChanged: (dateOfBirth) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Email',
          text: userInfo.email,
          onChanged: (email) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Phone Number',
          text: userInfo.phoneNumber,
          onChanged: (phoneNumber) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Postal Address',
          text: userInfo.postalAddress,
          maxLines: 5,
          onChanged: (postalAdress) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Residence Address',
          text: userInfo.residenceAddress,
          maxLines: 5,
          onChanged: (residenceAddress) {},
        ),
      ],
    );
  }



}

class EducationProfileSection extends StatelessWidget{

  final MyUser userInfo;

  const EducationProfileSection({
    Key key,
    this.userInfo,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<UserXP> educationList = userInfo.education;
    final UserXP educationItem = educationList[0];

    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        SizedBox(height: 10,),
        TextFieldWidget(
          label: 'Certificate & Field of Study',
          text: educationItem.title,
          onChanged: (title) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Institution Name',
          text: educationItem.institution,
          onChanged: (institution) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Start Date (yyyy.mm.dd)',
          text: educationItem.startDate,
          onChanged: (startDate) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'End Date (yyyy.mm.dd)',
          text: educationItem.endDate,
          onChanged: (endDate) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Additional Details',
          text: educationItem.extraDetails,
          maxLines: 4,
          onChanged: (extraDetails) {},
        ),
      ],
    );

  }


}

class WorkProfileSection extends StatelessWidget{

  final MyUser userInfo;

  const WorkProfileSection({
    Key key,
    this.userInfo,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<UserXP> workList = userInfo.work;
    final UserXP workItem = workList[0];

    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        SizedBox(height: 10,),
        TextFieldWidget(
          label: 'Job Title / Position',
          text: workItem.title,
          onChanged: (title) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Institution / Company Name',
          text: workItem.institution,
          onChanged: (institution) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Start Date (yyyy.mm.dd)',
          text: workItem.startDate,
          onChanged: (startDate) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'End Date (yyyy.mm.dd)',
          text: workItem.endDate,
          onChanged: (endDate) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Additional Details',
          text: workItem.extraDetails,
          maxLines: 4,
          onChanged: (extraDetails) {},
        ),
      ],
    );
  }

}

class ExtrasProfileSection extends StatelessWidget{

  final MyUser userInfo;

  const ExtrasProfileSection({
    Key key,
    this.userInfo,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> hobbies = userInfo.hobbies;
    final List<String> interests = userInfo.interests;
    final List<String> traits = userInfo.traits;

    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        SizedBox(height: 10,),
        EditListFieldWidget(
          label: 'What are your Strengths and Weaknesses?',
          text: '',
          onChanged: (trait){},
          editList: traits,
        ),
        SizedBox(height: 24,),
        EditListFieldWidget(
          label: 'What are your interests?',
          text: '',
          onChanged: (interest){},
          editList: interests,
        ),
        SizedBox(height: 24,),
        EditListFieldWidget(
          label: 'What are your hobbies?',
          text: '',
          onChanged: (hobby){},
          editList: hobbies,
        ),
        SizedBox(height: 10,),
      ],
    );
  }

}

class ProfileWidget extends StatelessWidget {

  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key key,
    this.imagePath,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 3,
            right: 3,
            child: buildEditIcon(color),
          ),
        ],
      ),
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

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 2,
    child: buildCircle(
      color: color,
      all: 8,
      child: FaIcon(
        FontAwesomeIcons.edit,
        color: Colors.white,
        size: 12,
      ),
    ),
  );

  Widget buildCircle({
    @required Color color,
    @required double all,
    @required Widget child,
  }) => ClipOval(
    child: Container(
      padding: EdgeInsets.all(all),
      color: color,
      child: child,
    ),
  );

  
}




