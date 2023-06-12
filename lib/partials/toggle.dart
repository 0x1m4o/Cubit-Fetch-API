import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cubitfetchapi/cubits/pagenav/pagenav_cubit.dart';
import 'package:cubitfetchapi/router/page_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Widget animatedToggle(BuildContext context) {
  return Builder(builder: (context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: AnimatedToggleSwitch<String>.size(
          animationDuration: const Duration(milliseconds: 100),
          indicatorSize: Size.infinite,
          current: context.read<PagenavCubit>().state.currentVal,
          values: const ['Sign Up', 'Sign In'],
          borderColor: Colors.transparent,
          borderWidth: 5.0,
          height: 55,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1.5),
            ),
          ],
          colorBuilder: (b) => Color.fromARGB(255, 106, 158, 237),
          innerColor: Colors.white,
          iconBuilder: (value, size) {
            return GestureDetector(
              onTap: () {
                context.read<PagenavCubit>().toggleText(value);
                context.read<PagenavCubit>().state.currentVal == 'Sign Up'
                    ? GoRouter.of(context).go(PageName.register)
                    : GoRouter.of(context).go(PageName.login);
              },
              child: Center(
                  child: Text(
                value,
                style: TextStyle(
                    fontSize: size.width * 0.55,
                    color:
                        context.watch<PagenavCubit>().state.currentVal == value
                            ? Colors.black87
                            : Colors.black54,
                    fontWeight: FontWeight.bold),
              )),
            );
          },
          onChanged: (value) {
            context.read<PagenavCubit>().toggleText(value);
            context.read<PagenavCubit>().state.currentVal == 'Sign Up'
                ? GoRouter.of(context).go(PageName.register)
                : GoRouter.of(context).go(PageName.login);
          }),
    );
  });
}
