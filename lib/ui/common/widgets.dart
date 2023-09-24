import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.controller,
      this.hint,
      required this.label,
      this.validator});

  final TextEditingController controller;
  final String? hint;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          labelText: label, border: const OutlineInputBorder(), hintText: hint),
    );
  }
}
