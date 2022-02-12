import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountSettingsScreen extends StatelessWidget {
  //const AccountSettingsScreen({Key? key}) : super(key: key);
  static const keyLanguage = 'key-language';
  static const keyLocation = 'key-location';

  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: 'Account Settings',
      subtitle: 'Privacy, Security, Language',
      leading: FaIcon(
        FontAwesomeIcons.userCircle,
        color: Colors.blueAccent,
      ),
      child: SettingsScreen(
        title: 'Account Settings',
        children: [
          buildLanguage(),
          buildLocation(),
          buildPrivacy(context),
          buildSecurity(context),
        ],
      ),
      onTap: (){},
    );
  }

  Widget buildPrivacy(BuildContext context)=> SimpleSettingsTile(
    title: 'Privacy',
    subtitle: '',
    leading: FaIcon(
      FontAwesomeIcons.lock,
      color: Colors.blueAccent,
    ),
    onTap: (){},
  );

  Widget buildSecurity(BuildContext context) => SimpleSettingsTile(
    title: 'Security',
    subtitle: '',
    leading: FaIcon(
      FontAwesomeIcons.shieldAlt,
      color: Colors.blueAccent,
    ),
    onTap: (){},
  );

  Widget buildLanguage() => DropDownSettingsTile(
    title: 'Language',
    subtitle: '',
    settingKey: keyLanguage,
    selected: 1,
    values: <int, String>{
      1: 'English',
      2: 'Chichewa',
    },
    onChange: (language){},
  );

  Widget buildLocation()=> TextInputSettingsTile(
    title: 'Location',
    settingKey: keyLocation,
    initialValue: 'Malawi',
    onChange: (location){},
  );

}
