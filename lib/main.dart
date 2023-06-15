import 'package:profileapp/cubits/auth/auth_cubit.dart';
import 'package:profileapp/cubits/pagenav/pagenav_cubit.dart';
import 'package:profileapp/cubits/response/response_cubit.dart';
import 'package:profileapp/models/login_response.dart';
import 'package:profileapp/models/user_response.dart';
import 'package:profileapp/router/app_page.dart';
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
