import 'package:flutter/gestures.dart';
import 'package:uassist/screens/auth/authentication_service.dart';
import 'package:uassist/screens/auth/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final registerHeaderText = Column(
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
                text: 'New to\n',
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

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xF5F5F5FF),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          context.read<AuthenticationService>().signUp(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          Navigator.pop(context);
        },
        child: Text("Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black)
        ),
      ),
    );

    final linkLogin  = Row(
      children: [
        Text('Already have an account? '),
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Text(
              'Sign In!!',
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
                      registerHeaderText,
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
                      registerButton,
                      SizedBox(height: 23,),
                      linkLogin,
                      SizedBox(height: 25,),
                    ],
                  ),
                )
            ),
          ),
        )
    );
  }

}