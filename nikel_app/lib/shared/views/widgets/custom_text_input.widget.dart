import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final String? Function(String?)? validator;
  const CustomTextInput({
    super.key,
    required this.label,
    required this.controller,
    this.isRequired = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: label,
      ),
      validator: validator ??
          (value) {
            if (!isRequired) return null;

            if (value == null || value.isEmpty) return 'Campo obrigatório';
            return null;
          },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
