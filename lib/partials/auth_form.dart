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
