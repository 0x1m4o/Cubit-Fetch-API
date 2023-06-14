import 'package:cubitfetchapi/cubits/auth/auth_cubit.dart';
import 'package:cubitfetchapi/cubits/pagenav/pagenav_cubit.dart';
import 'package:cubitfetchapi/cubits/response/response_cubit.dart';
import 'package:cubitfetchapi/models/login_response.dart';
import 'package:cubitfetchapi/models/user_response.dart';
import 'package:cubitfetchapi/router/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';


Box? box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserResponseAdapter());
  Hive.registerAdapter(LoginResponseAdapter());
  box = await Hive.openBox('box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => PagenavCubit(),
        ),
        BlocProvider(
          create: (context) => ResponseCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}