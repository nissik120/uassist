import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:uassist/screens/general/prime_widgets_headers.dart';

class NotificationsScreen extends StatefulWidget {
  // const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  final String pageTitle = 'How and when do we contact you\n';
  static const keyEmailAlert = 'key-email-alert';
  static const keyPushAlert = 'key-push-alert';
  static const keyNewsletter = 'key-newsletter';
  static const keyTips = 'key-tips';
  static const keySurvey = 'key-survey';
  static const keyComments = 'key-comments';
  static const keyReminders = 'key-reminders';

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
        baseCardNotif(context),
      ],
    );
  }

  //BASE LAYOUT WIDGETS

  Widget baseCardNotif(BuildContext context) => Card(
    elevation: 20.0,
    //color: Colors.white,
    margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 60.0),
    child: ListView(
      padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 18.0, bottom: 5.0),
      children: [
        SettingsGroup(
          title: 'Notifications From Us',
          children: [
            const SizedBox(height: 5,),
            buildCommModes(),
            buildCommType(),
          ],
        ),
        const SizedBox(height: 32,),
        SettingsGroup(
          title: 'Comments and Reminders',
          children: [
            const SizedBox(height: 5,),
            buildCommentAlerts(),
            buildReminderAlerts(),
          ],
        ),
      ],
    ),
  );


  Widget buildCommModes() => SimpleSettingsTile(
    title: 'Set medium of communication',
    subtitle: '',
    child: SettingsScreen(
      children: [
        SwitchSettingsTile(
          title: 'Email',
          subtitle: '',
          settingKey: keyEmailAlert,
        ),
        SwitchSettingsTile(
          title: 'Push Messages',
          subtitle: '',
          settingKey: keyPushAlert,
        ),
      ],
    ),
  );

  Widget buildCommType()=> SimpleSettingsTile(
    title: 'Choose Preferred Messages',
    subtitle: '',
    child: SettingsScreen(
      children: [
        SwitchSettingsTile(
          title: 'Receive our Newsletter',
          subtitle: '',
          settingKey: keyNewsletter,
        ),
        SwitchSettingsTile(
          title: 'Get Tips and Tutorials',
          subtitle: '',
          settingKey: keyTips,
        ),
        SwitchSettingsTile(
          title: 'User Research (Surveys)',
          subtitle: '',
          settingKey: keySurvey,
        ),
      ],
    ),
  );

  Widget buildCommentAlerts()=> RadioModalSettingsTile<int>(
    title: 'Comments',
    subtitle: 'These are notifications for comments on your posts and replies.',
    settingKey: keyComments,
    selected: 1,
    values: <int, String>{
      1: 'Do Not Notify Me',
      2: 'Mentions Only',
      3: 'All Comments',
    },
  );

  Widget buildReminderAlerts()=> RadioModalSettingsTile<int>(
    title: 'Reminders',
    subtitle: 'These are notifications on reminders for updates and your preferences',
    settingKey: keyReminders,
    selected: 1,
    values: <int, String>{
      1: 'Do Not Notify Me',
      2: 'Important Reminders Only',
      3: 'All Reminders',
    },
  );

}
