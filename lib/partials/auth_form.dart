// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  AuthForm({required this.thecontext, required this.relistView});
  ListView relistView;
  BuildContext thecontext;
  @override
  Widget build(BuildContext context) {
    return Expanded(child: relistView);
  }
}
