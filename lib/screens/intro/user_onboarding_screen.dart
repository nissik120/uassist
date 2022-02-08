import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuple/tuple.dart';
import 'package:uassist/delegates/sliver_persistent_header_delegate_impl.dart';
import 'package:uassist/screens/prime/prime_widgets/prime_widgets_headers.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/profile_edit_widgets.dart';

class UserOnBoardingScreen extends StatefulWidget {
  //const UserOnBoardingScreen({Key? key}) : super(key: key);

  @override
  _UserOnBoardingScreenState createState() => _UserOnBoardingScreenState();
}

class _UserOnBoardingScreenState extends State<UserOnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppIllustratorPage(),
      ),
    );
  }
}

class AppIllustratorPage extends StatelessWidget {

  const AppIllustratorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Image.asset(
              "assets/images/introDirect.png",
              scale: 0.6,
            ),
            Wrap(
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
                Text(
                  "Your Partner on the Academic Journey",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                Text(
                  "Helping you reach your destination.\nCreating a platform for growth.\nConnecting you to the people who care about your education.",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(
                        color: Colors.indigo,
                        width: 2.5,
                        style: BorderStyle.solid,
                      ),
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>UserIntroInfoPage()),
                    );
                  },
                  child: Text("Let's Get Started"),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}

class UserIntroInfoPage extends StatelessWidget {
  const UserIntroInfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimeWidgetsHeaders("Setup your account"),
        body: SafeArea(
          child: UserInfoAddPage(),
        )
    );
  }
}


class UserInfoAddPage extends StatefulWidget {
  const UserInfoAddPage({Key key}) : super(key: key);

  @override
  _UserInfoAddPageState createState() => _UserInfoAddPageState();
}

class _UserInfoAddPageState extends State<UserInfoAddPage> with SingleTickerProviderStateMixin {
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

