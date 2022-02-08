import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uassist/app_utils/my_shared_preferences.dart';
import 'package:uassist/model/user.dart';
import 'package:uassist/model/user_xp.dart';
import 'package:uassist/providers/user_intro_provider.dart';
import 'package:uassist/screens/prime/home_page.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/editlistfield_widget.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/textfield_widget.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/profile_display_widgets.dart';

/*
* PERSONAL SECTION
*
* */

class PersonalProfileSection extends StatelessWidget {
  const PersonalProfileSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserIntroProvider>(context);
    MyUser currentUser = userProvider.getUser();

    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 10,),
          ProfileWidget(
            imagePath: currentUser!=null?currentUser.imagePath:"",
            onClicked: (String imgPath){
              currentUser = currentUser.copyWith(imagePath: imgPath);
              userProvider.setUser(currentUser);
            },
          ),
          const SizedBox(height: 24),
          new TextFieldWidget(
            label: 'First Name(s)',
            text: currentUser!=null?currentUser.firstName:"",
            onChanged: (firstNameText) {
              currentUser = currentUser.copyWith(firstName: firstNameText);
              userProvider.setUser(currentUser);
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Last Name',
            text: currentUser!=null?currentUser.lastName:"",
            onChanged: (lastName) {
              currentUser = currentUser.copyWith(lastName: lastName);
              userProvider.setUser(currentUser);
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Date of Birth (yyyy.mm.dd)',
            text: currentUser!=null?currentUser.dateOfBirth:"",
            onChanged: (dateOfBirth) {
              currentUser = currentUser.copyWith(dateOfBirth: dateOfBirth);
              userProvider.setUser(currentUser);
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: currentUser!=null?currentUser.email:"",
            onChanged: (email) {
              currentUser = currentUser.copyWith(email: email);
              userProvider.setUser(currentUser);
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Phone Number',
            text: currentUser!=null?currentUser.phoneNumber:"",
            onChanged: (phoneNumber) {
              currentUser = currentUser.copyWith(phoneNumber: phoneNumber);
              userProvider.setUser(currentUser);
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Postal Address',
            text: currentUser!=null?currentUser.postalAddress:"",
            onChanged: (postal) {
              currentUser = currentUser.copyWith(postalAddress: postal);
              userProvider.setUser(currentUser);
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Residence Address',
            text: currentUser!=null?currentUser.residenceAddress:"",
            onChanged: (residenceAddress) {
              currentUser = currentUser.copyWith(residenceAddress: residenceAddress);
              userProvider.setUser(currentUser);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {

  final String imagePath;
  final Function(String) onClicked;

  const ProfileWidget({
    Key key,
    this.imagePath,
    this.onClicked,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
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
    final image = widget.imagePath.isNotEmpty ? FileImage(File(widget.imagePath)) : AssetImage("assets/images/userblank.png");

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Material(
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: (){
              getImage(true).then(
                    (value){
                  print(value);
                  widget.onClicked(value);
                },
              );
            },
          ),
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


  Future<String> getImage(bool gallery) async{
    String imgPath = "";
    ImagePicker picker = ImagePicker();

    if(gallery){
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if(pickedFile!=null) {
        imgPath = pickedFile.path;
      }
    }else{
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if(pickedFile!=null) {
        imgPath = pickedFile.path;
      }
    }
    return imgPath;

  }


}

/*
* EDUCATION SECTION
*
* */

class EducationProfileSection extends StatefulWidget{

  EducationProfileSection({
    Key key,
  }):super(key: key);

  @override
  State<EducationProfileSection> createState() => _EducationProfileSectionState();
}

class _EducationProfileSectionState extends State<EducationProfileSection> with AutomaticKeepAliveClientMixin {

  List<Widget> eduWidgets;
  Map<String, UserXP> values;
  var userProvider;
  MyUser currentUser;

  @override
  void initState() {
    super.initState();
    eduWidgets = [];
    values = Map();
  }

  void removeEduItem(index, String key){
    setState(() {
      List<UserXP> list = [];
      print('DELETED: $key');
      eduWidgets.remove(index);
      values.remove(key);
      values.forEach((key, value) { list.add(value);});
      currentUser = currentUser.copyWith(education: list);
      userProvider.setUser(currentUser);
    });
  }

  void addEduItem(){
    setState(() {
      var widgetItem = EducationItemWidget(removeEduItem, updateEduItem, key: UniqueKey(), itemIndex: eduWidgets.length);
      final widgetItemKey = widgetItem.key.toString();
      print('ADDED: $widgetItemKey');
      eduWidgets.add(widgetItem);
      values[widgetItemKey] = UserXP.createEmpty();
      print(values);
    });
  }

  void updateEduItem(item, String key, String field, String editText){
    List<UserXP> list = [];
    var editedMap = values[key].toMap();
    editedMap[field] = editText;
    values[key] = UserXP.fromMap(editedMap);
    values.forEach((key, value) { list.add(value);});
    currentUser = currentUser.copyWith(education: list);
    userProvider.setUser(currentUser);
  }

  @override
  Widget build(BuildContext context) {

    userProvider = Provider.of<UserIntroProvider>(context);
    currentUser = userProvider.getUser();

    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: (){
              addEduItem();
            },
            child: Text("+ Add Entry Form"),
          ),
          Column(
            children: this.eduWidgets,
          )
        ],
      ),
    );

  }

  @override
  bool get wantKeepAlive => true;
}

class EducationItemWidget extends StatelessWidget {

  final int itemIndex;
  final Function(EducationItemWidget, String) removeEduItem;
  final Function(EducationItemWidget, String key, String field, String editText) updateEduItem;

  EducationItemWidget(this.removeEduItem, this.updateEduItem, {Key key, @required this.itemIndex,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Education ${key.toString()}"),
            TextButton(
              onPressed: (){
                removeEduItem(this, key.toString());
              },
              child: Text("x Remove"),
            ),
          ],
        ),
        SizedBox(height: 10,),
        TextFieldWidget(
          label: 'Certificate & Field of Study',
          text: "",
          onChanged: (title) {
            updateEduItem(this, key.toString(), 'title', title);
          },
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Institution Name',
          text: "",
          onChanged: (institution) {
            updateEduItem(this, key.toString(), 'institution', institution);
          },
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Start Date (yyyy.mm.dd)',
          text: "",
          onChanged: (startDate) {
            updateEduItem(this, key.toString(), 'startDate', startDate);
          },
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'End Date (yyyy.mm.dd)',
          text: "",
          onChanged: (endDate) {
            updateEduItem(this, key.toString(), 'endDate', endDate);
          },
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Additional Details',
          text: "",
          maxLines: 4,
          onChanged: (extraDetails) {
            updateEduItem(this, key.toString(), 'extraDetails', extraDetails);
          },
        ),
        Divider(),
      ],
    );
  }
}

/*
* WORK SECTION
*
* */

class WorkProfileSection extends StatefulWidget{

  const WorkProfileSection({
    Key key,
  }):super(key: key);

  @override
  State<WorkProfileSection> createState() => _WorkProfileSectionState();
}

class _WorkProfileSectionState extends State<WorkProfileSection> with AutomaticKeepAliveClientMixin {

  List<Widget> workWidgets;
  Map<String, UserXP> values;
  var userProvider;
  MyUser currentUser;

  @override
  void initState() {
    super.initState();
    workWidgets = [];
    values = Map();
  }

  void removeWorkItem(index, String key){
    setState(() {
      List<UserXP> list = [];
      print('DELETED: $key');
      workWidgets.remove(index);
      values.remove(key);
      values.forEach((key, value) { list.add(value);});
      currentUser = currentUser.copyWith(work: list);
      userProvider.setUser(currentUser);
    });
  }

  void addWorkItem(){
    setState(() {
      var widgetItem = WorkItemWidget(removeWorkItem, updateWorkItem, key: UniqueKey(), itemIndex: workWidgets.length);
      final widgetItemKey = widgetItem.key.toString();
      print('ADDED: $widgetItemKey');
      workWidgets.add(widgetItem);
      values[widgetItemKey] = UserXP.createEmpty();
      print(values);
    });
  }

  void updateWorkItem(item, String key, String field, String editText){
    List<UserXP> list = [];
    var editedMap = values[key].toMap();
    editedMap[field] = editText;
    values[key] = UserXP.fromMap(editedMap);
    values.forEach((key, value) { list.add(value);});
    currentUser = currentUser.copyWith(work: list);
    userProvider.setUser(currentUser);
  }

  @override
  Widget build(BuildContext context) {

    userProvider = Provider.of<UserIntroProvider>(context);
    currentUser = userProvider.getUser();

    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              addWorkItem();
            },
            child: Text("+ Add Entry Form"),
          ),
          Column(
            children: this.workWidgets,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class WorkItemWidget extends StatelessWidget {

  final int itemIndex;
  final Function(WorkItemWidget, String) removeWorkItem;
  final Function(WorkItemWidget, String key, String field, String editText) updateWorkItem;

  const WorkItemWidget(this.removeWorkItem, this.updateWorkItem, {Key key, this.itemIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Occupation ${key.toString()}"),
            TextButton(
              onPressed: (){
                removeWorkItem(this, key.toString());
              },
              child: Text("x Remove"),
            ),
          ],
        ),
        SizedBox(height: 10,),
        TextFieldWidget(
          label: 'Job Title / Position',
          text: "",
          onChanged: (title) {
            updateWorkItem(this, key.toString(), 'title', title);
          },
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Institution / Company Name',
          text: "",
          onChanged: (institution) {
            updateWorkItem(this, key.toString(), 'institution', institution);
          },
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Start Date (yyyy.mm.dd)',
          text: "",
          onChanged: (startDate) {
            updateWorkItem(this, key.toString(), 'startDate', startDate);
          },
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'End Date (yyyy.mm.dd)',
          text: "",
          onChanged: (endDate) {
            updateWorkItem(this, key.toString(), 'endDate', endDate);
          },
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Additional Details',
          text: "",
          maxLines: 4,
          onChanged: (extraDetails) {
            updateWorkItem(this, key.toString(), 'extraDetails', extraDetails);
          },
        ),
      ],
    );
  }
}

/*
* EXTRAS SECTION
*
* */

class ExtrasProfileSection extends StatelessWidget {
  const ExtrasProfileSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserIntroProvider>(context);
    MyUser currentUser = userProvider.getUser();

    final List<String> hobbies = currentUser!=null? currentUser.hobbies:[];
    final List<String> interests = currentUser!=null? currentUser.interests:[];
    final List<String> traits = currentUser!=null? currentUser.traits:[];

    print(traits);

    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 10,),
          EditListFieldWidget(
            label: 'What are your Strengths and Weaknesses?',
            text: '',
            onChanged: (trait){
              traits.add(trait);
              currentUser = currentUser.copyWith(traits: traits);
              userProvider.setUser(currentUser);
            },
            editList: traits,
          ),
          SizedBox(height: 24,),
          EditListFieldWidget(
            label: 'What are your interests?',
            text: '',
            onChanged: (interest){
              interests.add(interest);
              currentUser = currentUser.copyWith(interests: interests);
              userProvider.setUser(currentUser);
            },
            editList: interests,
          ),
          SizedBox(height: 24,),
          EditListFieldWidget(
            label: 'What are your hobbies?',
            text: '',
            onChanged: (hobby){
              hobbies.add(hobby);
              currentUser = currentUser.copyWith(hobbies: hobbies);
              userProvider.setUser(currentUser);
            },
            editList: hobbies,
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}

/*
* SUMMARY SECTION
*
* */

class UserInfoSummarySection extends StatelessWidget {

  const UserInfoSummarySection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<UserIntroProvider>(context);
    MyUser userData = myProvider.getUser();

    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text("Summary", style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          UserPersonalWidget(
            isNetwork: false,
            imagePath: userData.imagePath,
            name: '${userData.firstName} ${userData.lastName}',
            email: userData.email,
            DoB: userData.dateOfBirth,
            phone: userData.phoneNumber,
            residence: userData.residenceAddress,
            postal: userData.postalAddress,
          ),
          SizedBox(height: 10,),
          buildXPGroup(context, "Education", userData.education,),
          SizedBox(height: 10,),
          buildXPGroup(context, "Experience", userData.work,),
          SizedBox(height: 10,),
          PersonalityExtrasWidget(
            groupTag: "Interests and Skills",
            interests: userData.interests,
            traits: userData.traits,
            hobbies: userData.hobbies,
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: (){
              myProvider.updateDatabase();
              MySharedPreferences.instance.setBooleanValue("firstTimeOpen", false);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>HomePage(),
                  ),
                  ModalRoute.withName("/Home")
              );
            },
            child: Text("Submit your details"),
          ),
        ],
      ),
    );
  }

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
          itemBuilder: (context, index) =>XPItemDetails(
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