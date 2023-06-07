import 'package:cubitfetchapi/cubits/auth/auth_cubit.dart';
import 'package:cubitfetchapi/models/login_request.dart';
import 'package:cubitfetchapi/router/page_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  @override
  void dispose() {
    emailC.clear();
    passC.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
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
          } else if (state is AuthSuccess) {
            GoRouter.of(context).go(PageName.home);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Login Success'),
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
          return state is AuthLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(children: [
                    TextField(
                      controller: emailC,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'johndoe@example.com',
                          labelText: 'Email'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passC,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your Password here',
                          labelText: 'Password'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    loginButton(context)
                  ]),
                );
        },
      ),
    );
  }

  ElevatedButton loginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.read<AuthCubit>().signInWithEmailPassword(
              LoginRequest(email: emailC.text, password: passC.text));
        },
        child: const Text('Submit'));
  }
}
