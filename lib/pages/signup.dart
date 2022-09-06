// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_final_fields, unused_field, deprecated_member_use

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:movies_app/pages/homepage.dart';
import 'package:movies_app/pages/loginPage.dart';
import 'package:movies_app/services/auth_services.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthService auth = AuthService();
  bool isCreated = false;
  void showSnackBar(BuildContext context, String error) {
    var snackBar = SnackBar(
      content: DefaultTextStyle(
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        child: Text(
          error,
          style: GoogleFonts.lobster(),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 134, 4, 48),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeIn(
                curve: Curves.easeOut,
                duration: Duration(seconds: 1),
                child: (DefaultTextStyle(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        "Sign Up",
                      ),
                    ],
                    repeatForever: true,
                  ),
                )),
              ),
              SizedBox(
                height: 10,
              ),
              FadeIn(
                curve: Curves.easeOut,
                duration: Duration(seconds: 2),
                child: InkWell(
                  onTap: () async {
                    /// This Will Sign Up User Via goole service.
                    await auth.googleLogin(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 60,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/google.svg',
                            height: 25,
                            width: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DefaultTextStyle(
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            child: Text(
                              "Continue With Google",
                              style: GoogleFonts.lobster(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              FadeIn(
                curve: Curves.easeOut,
                duration: Duration(seconds: 2),
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  child: Text(
                    "Or",
                    style: GoogleFonts.lobster(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FadeIn(
                  curve: Curves.easeOut,
                  duration: Duration(seconds: 3),
                  child:
                      TextField(context, "Email...", false, _emailController)),
              SizedBox(
                height: 20,
              ),
              FadeIn(
                  curve: Curves.easeOut,
                  duration: Duration(seconds: 3),
                  child: TextField(
                      context, "Password...", true, _passwordController)),
              SizedBox(
                height: 20,
              ),
              FadeIn(
                curve: Curves.easeOut,
                duration: Duration(seconds: 4),
                child: InkWell(
                  onTap: () async {
                    /// This will Sign Up new user via firebase auth...
                    setState(() {
                      isCreated = true;
                    });
                    try {
                      await auth.signUp(
                          _emailController.text, _passwordController.text);
                      _emailController.clear();
                      _passwordController.clear();
                      setState(() {
                        isCreated = false;
                      });
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ), (route) => false);
                    } catch (error) {
                      showSnackBar(context, error.toString());
                      setState(() {
                        isCreated = false;
                      });
                    }
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 90,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xfffd746c),
                            Color(0xffff9068),
                            Color(0xfffd746c),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        child: isCreated
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Create",
                                style: GoogleFonts.lobster(),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FadeIn(
                curve: Curves.easeOut,
                duration: Duration(seconds: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      child: Text("If you already have an Account ? ",
                          style: GoogleFonts.lobster()),
                    ),
                    InkWell(
                      onTap: () {
                        /// This Will navigate To the login Screeen.
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ), (route) => false);
                      },
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Text("Login ", style: GoogleFonts.lobster()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget TextField(BuildContext context, String labelText, bool obsText,
    TextEditingController controller) {
  return Container(
    height: 60,
    width: MediaQuery.of(context).size.width - 70,
    child: TextFormField(
      controller: controller,
      obscureText: obsText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
  );
}
