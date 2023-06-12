import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  const TextForm({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.hint,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2)),
            floatingLabelStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700),
            prefixIcon: Icon(icon, color: Colors.grey),
            prefixStyle: const TextStyle(),
            border: const OutlineInputBorder(),
            hintText: hint,
            labelText: label),
      ),
    );
  }
}
