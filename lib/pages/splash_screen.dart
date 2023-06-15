// ignore_for_file: use_build_context_synchronously

import 'package:profileapp/models/login_response.dart';
import 'package:profileapp/models/user_response.dart';
import 'package:profileapp/pages/homepage.dart';
import 'package:profileapp/pages/register.dart';
import 'package:flutter/material.dart';
import '/utils/constant.dart' as constants;
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
    widget.loginResponse = await widget.box.get(constants.loginRespStorage);
    if (widget.loginResponse != null &&
        widget.loginResponse!.token.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(
          loginResponse: widget.loginResponse!,
        ),
      ));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => RegisterPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
