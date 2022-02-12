import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uassist/providers/theme_provider.dart';
import 'package:uassist/screens/auth/authentication_service.dart';
import 'package:uassist/screens/prime/home_page_widgets/account_settings/account_settings_screen.dart';
import 'package:uassist/screens/general/prime_widgets_headers.dart';

class SettingsScreen extends StatefulWidget {
  //const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  //CONSTANTS OR STATICS
  final String pageTitle = 'Define some app functionality\n';

  static const keyDarkMode = 'key-dark-mode';

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: PrimeWidgetsHeaders(pageTitle),
          ),
          baseCard(context),
        ],
      );
  }

  //BASE LAYOUT WIDGETS

  Widget baseCard(BuildContext context) => Card(
    elevation: 20.0,
    //color: Colors.white,
    margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 60.0),
    child: ListView(
      padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 18.0, bottom: 5.0),
      children: <Widget>[
        buildDarkMode(),
        SettingsGroup(
          title: 'General',
          children: <Widget>[
            const SizedBox(height: 5,),
            AccountSettingsScreen(),
            buildAbout(),
            buildLogout(context),
          ],
        ),
        const SizedBox(height: 32,),
        SettingsGroup(
          title: 'Feedback',
          children: <Widget>[
            const SizedBox(height: 5,),
            buildReportBug(),
            buildSendFeedback(),
          ],
        )
      ],
    ),
  );

  //SETTINGS OPTIONS: WIDGETS
  Widget buildDarkMode()=> SwitchSettingsTile(
    title: 'Dark Mode',
    settingKey: keyDarkMode,
    leading: FaIcon(
      FontAwesomeIcons.adjust,
      color: Color(0xFF642ef3),
    ),
    onChange: (_){
      Provider.of<ThemeProvider>(context, listen: false).toggleMode();
      var a = Provider.of<ThemeProvider>(context, listen: false).mode==ThemeMode.dark;
      print('Dark mode On: $a');
    },
  );

  Widget buildLogout(BuildContext context) => SimpleSettingsTile(
    title: 'Logout',
    subtitle: '',
    leading: FaIcon(
      FontAwesomeIcons.signOutAlt,
      color: Colors.blueAccent,
    ),
    onTap: (){
      context.read<AuthenticationService>().signOut();
    },
  );

  Widget buildAbout() => SimpleSettingsTile(
    title: 'About the App',
    subtitle: 'FAQ, Terms and Conditions and Developers',
    leading: FaIcon(
      FontAwesomeIcons.questionCircle,
      color: Colors.blueAccent,
    ),
    child: Container(),
    onTap: (){},
  );

  Widget buildReportBug()=> SimpleSettingsTile(
    title: 'Report A Bug',
    subtitle: '',
    leading: FaIcon(
      FontAwesomeIcons.bug,
      color: Colors.blueAccent,
    ),
    onTap: (){},
  );

  Widget buildSendFeedback()=> SimpleSettingsTile(
    title: 'Send Feedback',
    subtitle: '',
    leading: FaIcon(
      FontAwesomeIcons.thumbsUp,
      color: Colors.blueAccent,
    ),
    onTap: (){},
  );

}
