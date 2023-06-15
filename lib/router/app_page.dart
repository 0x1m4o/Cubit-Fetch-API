import 'package:profileapp/models/login_response.dart';
import 'package:profileapp/pages/edit.dart';
import 'package:profileapp/pages/homepage.dart';
import 'package:profileapp/pages/login.dart';
import 'package:profileapp/pages/register.dart';
import 'package:profileapp/pages/splash_screen.dart';
import 'package:profileapp/router/page_name.dart';
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
