// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, unused_import, unnecessary_null_comparison

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/pages/homepage.dart';
import 'package:movies_app/pages/loginpage.dart';
import 'package:movies_app/services/auth_services.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Widget currentPage = LoginPage();
  void checkLogin() async {
    AuthService auth = AuthService();
    String token = await auth.checkLogin();
    if (token != 'Logged Out') {
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return currentPage;
  }
}
