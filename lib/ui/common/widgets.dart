import 'package:flutter/material.dart';
import 'ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.controller,
      this.hint,
      this.prefixIcon,
      required this.label,
      this.validator,
      this.obscureText,
      this.decoration});

  final TextEditingController controller;
  final String? hint;
  final String label;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  final bool? obscureText;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        verticalSpaceTiny,
        TextFormField(
          obscureText: obscureText ?? false,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hint,
              prefixIcon: prefixIcon,
              floatingLabelBehavior: FloatingLabelBehavior.never),
        ),
      ],
    );
  }
}

class ProfileTextField extends StatelessWidget {
  const ProfileTextField(
      {super.key,
      this.initialValue,
      this.isEditing,
      required this.label,
      this.controller,
      required this.prefixIcon});

  final String? initialValue;
  final TextEditingController? controller;
  final bool? isEditing;
  final String label;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          verticalSpaceTiny,
          TextFormField(
            controller: controller,
            initialValue: initialValue,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              prefixIcon: prefixIcon,
            ),
            enabled: isEditing ?? false,
          ),
          verticalSpaceMedium
        ],
      ),
    );
  }
}

void showError(String? message) {
  final context = StackedService.navigatorKey!.currentContext;
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        backgroundColor: Colors.red,
      ),
    );
  }
}
