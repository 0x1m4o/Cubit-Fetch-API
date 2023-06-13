import 'package:cubitfetchapi/models/login_response.dart';
import 'package:cubitfetchapi/pages/edit.dart';
import 'package:cubitfetchapi/pages/homepage.dart';
import 'package:cubitfetchapi/pages/login.dart';
import 'package:cubitfetchapi/pages/register.dart';
import 'package:cubitfetchapi/pages/splash_screen.dart';
import 'package:cubitfetchapi/router/page_name.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: PageName.splash, routes: [
  GoRoute(
    path: PageName.splash,
    builder: (context, state) => SplashScreen(),
  ),
  GoRoute(
    path: PageName.home,
    builder: (context, state) =>
        HomePage(loginResponse: LoginResponse.initial()),
  ),
  GoRoute(
    path: PageName.login,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: PageName.login,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: PageName.register,
    builder: (context, state) => RegisterPage(),
  ),
  GoRoute(
    path: PageName.edit,
    builder: (context, state) => EditPage(),
  ),
]);
