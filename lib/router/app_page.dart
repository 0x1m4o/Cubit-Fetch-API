import 'package:cubitfetchapi/pages/homepage.dart';
import 'package:cubitfetchapi/pages/login.dart';
import 'package:cubitfetchapi/router/page_name.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: PageName.login, routes: [
  GoRoute(
    path: PageName.login,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: PageName.home,
    builder: (context, state) => const HomePage(),
  ),
]);
