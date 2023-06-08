// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cubitfetchapi/cubits/response/response_cubit.dart';
import 'package:cubitfetchapi/models/user_response.dart';
import 'package:flutter/material.dart';

import 'package:cubitfetchapi/models/login_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final String tokenResponse;
  final String userResponse;
  LoginResponse loginResponse;

  HomePage({
    this.tokenResponse = '',
    required this.loginResponse,
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.loginResponse.username),
      ),
      body: Center(
        child: BlocConsumer<ResponseCubit, ResponseState>(
          listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              loading: (value) {
                print("Is loading");
              },
              success: (value) {
                print(value.userResponse.toJson());
              },
            );
          },
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => homePageError(context, widget.loginResponse),
              loading: (e) => homePageLoading(),
              success: (value) => homePageScaffold(value.userResponse),
              error: (value) => homePageError(context, widget.loginResponse),
            );
          },
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
  return Container(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Something worng"),
        IconButton(
          onPressed: () {
            context
                .read<ResponseCubit>()
                .getAllDataOfUser(loginResponse.username, loginResponse.token);
          },
          icon: Icon(Icons.replay),
        )
      ],
    ),
  );
}

Widget homePageScaffold(UserResponse userResponse) {
  return Column(
    children: [
      Text(userResponse.fullname),
      Text(userResponse.city),
      Text(userResponse.country),
      Text(userResponse.job),
      Text(userResponse.about),
      Text(userResponse.instagram),
      Text(userResponse.facebook),
      Text(userResponse.twitter),
    ],
  );
}
