// ignore_for_file: use_build_context_synchronously

import 'package:cubitfetchapi/models/login_response.dart';
import 'package:cubitfetchapi/models/user_response.dart';
import 'package:cubitfetchapi/pages/homepage.dart';
import 'package:cubitfetchapi/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatefulWidget {
  late Box box;
  LoginResponse? loginResponse;
  UserResponse? savedUserResponse;
  SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  void getInitialData() async {
    widget.box = await Hive.openBox('box');
    widget.loginResponse = await widget.box.get('loginResp');
    if (widget.loginResponse != null &&
        widget.loginResponse!.token.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(
          userResponse: widget.loginResponse!.username,
          tokenResponse: widget.loginResponse!.token,
          loginResponse: widget.loginResponse!,
        ),
      ));
                                                                                          
    } else {
      print("Data Null");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => RegisterPage()));
    }
  }

  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
