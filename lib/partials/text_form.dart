import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final String hint;
  
  const TextForm({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.hint,
  }) : super(key: key);

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
