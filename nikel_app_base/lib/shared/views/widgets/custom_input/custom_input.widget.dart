import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../themes/app_colors.dart';
import 'custom_input.store.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController _controller;
  final String _hintText;
  final String _label;
  final bool _isPassword;
  final String? Function(String?)? _validator;
  final void Function()? _onTap;
  final bool _readOnly;
  final TextInputType? _keyboardType;
  final List<TextInputFormatter>? _inputFormatters;

  CustomInput({
    super.key,
    required TextEditingController controller,
    required String hintText,
    required String label,
    bool isPassword = false,
    String? Function(String?)? validator,
    void Function()? onTap,
    bool readOnly = false,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  })  : _controller = controller,
        _hintText = hintText,
        _label = label,
        _isPassword = isPassword,
        _validator = validator,
        _onTap = onTap,
        _readOnly = readOnly,
        _keyboardType = keyboardType,
        _inputFormatters = inputFormatters;

  final store = CustomInputStore();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return TextFormField(
          keyboardType: _keyboardType,
          readOnly: _readOnly,
          onTap: _onTap,
          inputFormatters: _inputFormatters,
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: _hintText,
            suffixIcon: _isPassword
                ? IconButton(
                    icon: Icon(
                      !store.obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => store.setObscurePassword(),
                  )
                : null,
          ),
          validator: _validator ??
              (_) {
                if (_controller.text.isEmpty) {
                  return 'Preencha este campo';
                }
                return null;
              },
          obscureText:
              _isPassword ? !store.obscurePassword : store.obscurePassword,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        );
      },
    );
  }
}
