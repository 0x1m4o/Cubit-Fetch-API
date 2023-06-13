// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:cubitfetchapi/cubits/auth/auth_cubit.dart';
import 'package:cubitfetchapi/partials/toggle.dart';
import 'package:cubitfetchapi/models/login_request.dart';
import 'package:cubitfetchapi/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:particles_flutter/particles_flutter.dart';
import '../partials/text_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userC = TextEditingController();
  TextEditingController passC = TextEditingController();
  @override
  void dispose() {
    userC.clear();
    passC.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              print('Loading');
            } else if (state is AuthError) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: Text(state.errorMsg),
                    );
                  });
            } else if (state is AuthLoginSuccess) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(
                  loginResponse: state.data,
                  userResponse: state.data.username,
                  tokenResponse: state.data.token,
                ),
              ));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.data.msg),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
              ));
            }
          },
          builder: (context, state) {
            return CircularParticle(
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
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: BottomAppBar(
                elevation: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(182, 63, 164, 227),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ScrollConfiguration(
                    behavior: const MaterialScrollBehavior()
                        .copyWith(overscroll: false),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          const Text(
                            'Profile Card',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          animatedToggle(context),
                          Expanded(
                            child: ListView(children: [
                              TextForm(
                                  icon: Icons.person_outlined,
                                  controller: userC,
                                  label: 'Username',
                                  hint: 'Enter your username'),
                              TextForm(
                                  icon: Icons.password,
                                  controller: passC,
                                  label: 'Password',
                                  hint: 'Enter your Password'),
                              loginButton(context),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 73, 66, 228)),
          onPressed: () {
            context.read<AuthCubit>().signInWithEmailPassword(
                LoginRequest(username: userC.text, password: passC.text));
          },
          child: const Text('Submit')),
    );
  }
}
