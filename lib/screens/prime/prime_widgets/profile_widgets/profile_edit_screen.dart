import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuple/tuple.dart';
import 'package:uassist/delegates/sliver_persistent_header_delegate_impl.dart';
import 'package:uassist/model/user.dart';
import 'package:uassist/model/user_xp.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/editlistfield_widget.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/profile_edit_widgets.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/profile_sliver_app_bar.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/textfield_widget.dart';

class ProfileEditScreen extends StatefulWidget {

  const ProfileEditScreen({
    Key key,
  }) : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> with SingleTickerProviderStateMixin {
  
  TabController _tabController;
  List<Tuple3> _sections;


  @override
  void initState() {
    super.initState();
    _sections = [
      Tuple3("Personal", PersonalProfileSection(), FaIcon(FontAwesomeIcons.userAlt, size: 12,)),
      Tuple3("Education", EducationProfileSection(), FaIcon(FontAwesomeIcons.graduationCap, size: 12,)),
      Tuple3("Experience", WorkProfileSection(), FaIcon(FontAwesomeIcons.briefcase, size: 12,)),
      Tuple3("Other Details", ExtrasProfileSection(), FaIcon(FontAwesomeIcons.userPlus, size: 12,)),
      Tuple3("Summary", UserInfoSummarySection(), FaIcon(FontAwesomeIcons.listAlt, size: 12,)),
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




