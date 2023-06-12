// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:cubitfetchapi/cubits/response/response_cubit.dart';
import 'package:cubitfetchapi/models/user_response.dart';
import 'package:cubitfetchapi/pages/edit.dart';
import 'package:cubitfetchapi/router/page_name.dart';
import 'package:flutter/material.dart';

import 'package:cubitfetchapi/models/login_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:particles_flutter/particles_flutter.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  final String tokenResponse;
  final String userResponse;
  LoginResponse? loginResponse;
  late Box box;
  UserResponse? savedUserResponse;

  HomePage({
    super.key,
    this.tokenResponse = '',
    this.loginResponse,
    this.userResponse = '',
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context
        .read<ResponseCubit>()
        .getAllDataOfUser(widget.userResponse, widget.tokenResponse);

    getUserData();
    super.initState();
  }

  void getUserData() async {
    widget.box = await Hive.openBox('box');
    widget.box.put('loginResp', widget.loginResponse);
    final finalLoginResponse = widget.box.get('loginResp');
    if (finalLoginResponse != null) {
      widget.loginResponse = finalLoginResponse!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: BlocConsumer<ResponseCubit, ResponseState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                loading: (value) {
                  print("Is loading");
                },
                success: (value) {
                  widget.savedUserResponse = value.userResponse;
                  widget.box.put('userResp', widget.savedUserResponse);
                },
              );
            },
            builder: (context, state) {
              return state.maybeMap(
                orElse: () => homePageError(context, widget.loginResponse!),
                loading: (e) => homePageLoading(),
                success: (value) => homePageScaffold(
                    context,
                    widget.savedUserResponse!,
                    widget.box,
                    widget.userResponse,
                    widget.tokenResponse,
                    widget.loginResponse!),
                error: (value) => homePageError(context, widget.loginResponse!),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget homePageLoading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget homePageError(BuildContext context, LoginResponse loginResponse) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Something worng"),
        IconButton(
          onPressed: () {
            context
                .read<ResponseCubit>()
                .getAllDataOfUser(loginResponse.username, loginResponse.token);
          },
          icon: const Icon(Icons.replay),
        )
      ],
    ),
  );
}

Widget homePageScaffold(BuildContext context, UserResponse userResponse,
    Box box, String username, String token, LoginResponse loginResponse) {
  final regex = RegExp(r'base64,(.*)');
  final match = regex.firstMatch(userResponse.avatar);
  final base64String = match!.group(1)!;
  Uint8List bytes = base64Decode(base64String);

  return Stack(children: [
    CircularParticle(
      awayRadius: 50,
      numberOfParticles: 300,
      speedOfParticles: 1,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      onTapAnimation: true,
      particleColor: Colors.grey,
      awayAnimationDuration: const Duration(milliseconds: 100),
      maxParticleSize: 5,
      isRandSize: false,
      isRandomColor: false,
      awayAnimationCurve: Curves.bounceInOut,
      enableHover: true,
      hoverColor: Colors.white,
      hoverRadius: 80,
      key: UniqueKey(),
      connectDots: true,
    ),
    Padding(
      padding: const EdgeInsets.all(25),
      child: Card(
        elevation: 10,
        color: Color.fromARGB(255, 79, 112, 156),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await box.delete('loginResp');
                          await box.delete('userResp');
                          await box.close();
                          await Hive.close();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditPage(
                              savedUserResponse: userResponse,
                              userResponse: username,
                              tokenResponse: token,
                            ),
                          ));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  userResponse.fullname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  '${userResponse.city}, ${userResponse.country}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white54,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  userResponse.job,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.white54,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  userResponse.about,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white54,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Instagram',
                          style: TextStyle(color: Colors.white30),
                        )),
                    OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Twitter',
                          style: TextStyle(color: Colors.white30),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  ]);
}
