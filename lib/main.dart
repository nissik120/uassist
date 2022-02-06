import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_settings_screens/src/settings.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:uassist/app_utils/my_shared_preferences.dart';
import 'package:uassist/providers/theme_provider.dart';
import 'package:uassist/providers/user_intro_provider.dart';
import 'package:uassist/screens/auth/authentication_service.dart';
import 'package:uassist/screens/auth/sign_in_page.dart';
import 'package:uassist/screens/intro/user_onboarding_screen.dart';
import 'package:uassist/screens/prime/home_page.dart';

Future<void> main() async{
  await Settings.init(cacheProvider: SharePreferenceCache());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            initialData: null,
              create: (context)=> context.read<AuthenticationService>().authStateChanges,
          ),
          ChangeNotifierProvider(
            create: (context)=>ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>UserIntroProvider(),
          )
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeObject, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'UAssist Demo',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeObject.mode,
            home: LoaderScreen(),
          ),
        ),
    );
  }

}

class LoaderScreen extends StatefulWidget{
  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen>{

  bool isFirstTimeOpen = false;

  _LoaderScreenState(){
    MySharedPreferences.instance
        .getBooleanValue("firstTimeOpen")
        .then((value) => setState((){
          isFirstTimeOpen = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds:6,
      navigateAfterSeconds: new AuthenticationWrapper(isFirstTimeOpen: this.isFirstTimeOpen,),
      image: new Image.asset("assets/logo/uassist-logo-clean.png"),
      photoSize: 100,
      backgroundColor: Colors.black,
      loaderColor: Colors.white,
    );
  }

}

class AuthenticationWrapper extends StatelessWidget {

  final bool isFirstTimeOpen;

  const AuthenticationWrapper({
    Key key,
    this.isFirstTimeOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if(firebaseUser!=null){
      return isFirstTimeOpen? UserOnBoardingScreen() : HomePage();
    }
    return SignInPage();
    //return HomePage();
  }

  Future checkFirstSeen() async{

  }

}

class MyTheme with ChangeNotifier{

  static bool _isDark = true;

  ThemeMode currentTheme(){
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme(){
    _isDark = !_isDark;
    notifyListeners();
  }
}
