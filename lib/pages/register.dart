// ignore_for_file: avoid_print, must_be_immutable, use_build_context_synchronously

import 'package:cubitfetchapi/cubits/pagenav/pagenav_cubit.dart';
import 'package:cubitfetchapi/models/login_response.dart';
import 'package:cubitfetchapi/models/user_response.dart';
import 'package:cubitfetchapi/pages/homepage.dart';
import 'package:cubitfetchapi/partials/toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:cubitfetchapi/cubits/auth/auth_cubit.dart';
import 'package:cubitfetchapi/models/register_request.dart';
import 'package:cubitfetchapi/router/page_name.dart';
import '../partials/text_form.dart';

class RegisterPage extends StatefulWidget {
  late Box box;
  UserResponse? finalUserResponse;
  LoginResponse? finalLoginResponse;

  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController fullNameC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  @override
  void dispose() {
    userC.clear();
    passC.clear();
    fullNameC.clear();
    cityC.clear();
    countryC.clear();
    jobC.clear();
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
            } else if (state is AuthRegisterSuccess) {
              context.read<PagenavCubit>().toggleText('Sign In');
              GoRouter.of(context).go(PageName.login);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.data.msg),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 100,
                    right: 20,
                    left: 20),
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
                  height: MediaQuery.of(context).size.height * 0.7,
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
                              TextForm(
                                  icon: Icons.add_card_rounded,
                                  controller: fullNameC,
                                  label: 'Fullname',
                                  hint: 'Enter your Fullname'),
                              TextForm(
                                  icon: Icons.location_city,
                                  controller: cityC,
                                  label: 'City',
                                  hint: 'Enter your City'),
                              TextForm(
                                  icon: Icons.flag_outlined,
                                  controller: countryC,
                                  label: 'Country',
                                  hint: 'Enter your Country'),
                              TextForm(
                                  icon: Icons.work,
                                  controller: jobC,
                                  label: 'Job',
                                  hint: 'Enter your Job'),
                              registerButton(context),
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

  Widget registerButton(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 73, 66, 228)),
          onPressed: () {
            var request = RegisterRequest(
              username: userC.text,
              password: passC.text,
              fullname: fullNameC.text,
              country: countryC.text,
              job: jobC.text,
              city: cityC.text,
            );
            context.read<AuthCubit>().registerWithEmailPassword(request);
          },
          child: const Text('Submit')),
    );
  }
}
