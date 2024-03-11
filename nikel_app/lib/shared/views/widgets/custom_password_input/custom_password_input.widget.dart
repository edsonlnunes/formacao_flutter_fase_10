import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'custom_password_input.store.dart';

class CustomPasswordInput extends StatelessWidget {
  final store = CustomPasswordInputStore();
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  CustomPasswordInput({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: label,
          suffixIcon: IconButton(
            onPressed: store.toggleObscureText,
            icon: Icon(
              store.obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
        obscureText: store.obscureText,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) return 'Campo obrigatório';
              if (value.length < 6) return 'Minímo 6 caracteres';
              return null;
            },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );
    });
  }
}
