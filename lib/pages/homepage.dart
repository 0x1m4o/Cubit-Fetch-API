// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:particles_flutter/particles_flutter.dart';

import 'package:cubitfetchapi/cubits/response/response_cubit.dart';
import 'package:cubitfetchapi/models/login_response.dart';
import 'package:cubitfetchapi/models/user_response.dart';
import 'package:cubitfetchapi/pages/edit.dart';

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
    super.initState();
    context.read<ResponseCubit>().getAllDataOfUser(
        widget.loginResponse!.username, widget.loginResponse!.token);
    getUserData();
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
    print('widget.loginResponse : ${widget.loginResponse!.username}');

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: BlocConsumer<ResponseCubit, ResponseState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (value) {
                  widget.savedUserResponse = value.userResponse;
                  widget.box.put('userResp', widget.savedUserResponse);
                },
              );
            },
            builder: (context, state) {
              return state.maybeMap(
                orElse: () {
                  return homePageLoading();
                },
                success: (_) {
                  return HomePageScaffold(
                      userResponse: widget.savedUserResponse!,
                      box: widget.box,
                      username: widget.userResponse,
                      token: widget.tokenResponse,
                      loginResponse: widget.loginResponse!);
                },
                error: (_) => homePageError(),
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

Widget homePageError() {
  return const Center(
    child: Text('error'),
  );
}

class HomePageScaffold extends StatefulWidget {
  UserResponse userResponse;
  Box box;
  String username;
  String token;
  LoginResponse loginResponse;
  HomePageScaffold({
    Key? key,
    required this.userResponse,
    required this.loginResponse,
    required this.username,
    required this.token,
    required this.box,
  }) : super(key: key);

  @override
  State<HomePageScaffold> createState() => _HomePageScaffoldState();
}

class _HomePageScaffoldState extends State<HomePageScaffold> {
  @override
  Widget build(BuildContext context) {
    final regex = RegExp(r'base64,(.*)');
    final match = regex.firstMatch(widget.userResponse.avatar);
    final base64String = match?.group(1);
    Uint8List? bytes = base64String != null ? base64Decode(base64String) : null;
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
                            await widget.box.delete('loginResp');
                            await widget.box.delete('userResp');
                            await widget.box.close();
                            await Hive.close();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () async {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: context.read<ResponseCubit>(),
                                    child: EditPage(
                                      loginResponse: widget.loginResponse,
                                      savedUserResponse: widget.userResponse,
                                      userResponse: widget.username,
                                      tokenResponse: widget.token,
                                    ),
                                  ),
                                ))
                                .then((_) => setState(() {
                                      context
                                          .read<ResponseCubit>()
                                          .getAllDataOfUser(
                                              widget.loginResponse.username,
                                              widget.loginResponse.token);
                                    }));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: bytes != null
                        ? Image.memory(
                            bytes,
                            fit: BoxFit.cover,
                          )
                        : SizedBox(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.userResponse.fullname,
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
                    '${widget.userResponse.city}, ${widget.userResponse.country}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white54,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.userResponse.job,
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
                    widget.userResponse.about,
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
}
