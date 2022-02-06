import 'package:flutter/gestures.dart';
import 'package:uassist/screens/auth/authentication_service.dart';
import 'package:uassist/screens/auth/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final headerText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/logo/uassist-logo-solo-clean.png',
          width: 70,
          height: 70,
        ),
        SizedBox(height: 15,),
        Text.rich(
            TextSpan(
                text: 'Welcome to\n',
                children: <TextSpan>[
                  TextSpan(
                      text: 'UASSIST',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ]
            )
        )
      ],
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xF5F5F5FF),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          print("Clicked");
          context.read<AuthenticationService>().signIn(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
        },
        child: Text("Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black)
        ),
      ),
    );

    final linkRegister  = Row(
      children: [
        Text('Do not have an account yet? '),
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            );
          },
          child: Text(
              'Sign Up!!',
              style: TextStyle(fontWeight: FontWeight.bold)
          ),
        )
      ],
    );

    final linkReset  = Row(
      children: [
        Text('Forgot your password? '),
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            );
          },
          child: Text(
              'Reset Password!!',
              style: TextStyle(fontWeight: FontWeight.bold)
          ),
        )
      ],
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerText,
                SizedBox(height: 45,),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Enter Your Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Enter Your Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                loginButton,
                SizedBox(height: 23,),
                linkRegister,
                SizedBox(height: 25,),
                linkReset,
                SizedBox(height: 15,),
              ],
            ),
          )
          ),
        ),
      )
    );
  }



}