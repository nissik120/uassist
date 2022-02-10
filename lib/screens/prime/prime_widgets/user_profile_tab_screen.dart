import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uassist/providers/user_intro_provider.dart';
import 'package:uassist/screens/prime/prime_widgets/prime_widgets_headers.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/profile_edit_screen.dart';
import 'package:uassist/screens/prime/prime_widgets/profile_widgets/profile_preview_screen.dart';

class UserProfileTabScreen extends StatefulWidget {
  const UserProfileTabScreen({Key key}) : super(key: key);

  @override
  _UserProfileTabScreenState createState() => _UserProfileTabScreenState();
}

class _UserProfileTabScreenState extends State<UserProfileTabScreen> {

  final String pageTitle = "Tell us and others about you\n";
  bool isUserExisting;
  bool isPreviewMode;

  @override
  void initState() {
    isUserExisting = false;
    isPreviewMode = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    checkIfUserExisting(context);

    return Stack(
      children: [
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: PrimeWidgetsHeaders(pageTitle),
        ),
        isUserExisting ? previewCard(context): contentFailState(),
      ],
    );
  }

  void checkIfUserExisting(BuildContext context){
    final userProvider = Provider.of<UserIntroProvider>(context);
    userProvider.readDatabase().then(
            (value) => setState((){
              isUserExisting = value;
            })
    );
  }

  void toggleViewMode(){
    setState(() {
      isPreviewMode = !isPreviewMode;
    });
  }


  Widget contentFailState() => Container(
    margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 100.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.deepOrange,
          ),
          TextButton(
            onPressed: (){},
            child: Text('Refresh'),
          ),
        ],
      ),
    ),
  );

  Widget previewCard(BuildContext context) => Card(
    elevation: 20.0,
    //color: Colors.white,
    margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 60.0),
    child: Padding(
      padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 18.0, bottom: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: (){toggleViewMode();},
                child: Text(
                    isPreviewMode ? 'Edit Profile' : 'Close Edit'
                ),
              ),
            ],
          ),
          Expanded(
            child: isPreviewMode ? ProfilePreviewScreen() : ProfileEditScreen(),
          )
        ],
      ),
    ),
  );

  @override
  void dispose() {

    super.dispose();
  }

}
