import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/views/modals/error.modal.dart';
import '../../../../shared/views/widgets/custom_button.widget.dart';
import '../../../../shared/views/widgets/custom_password_input/custom_password_input.widget.dart';
import '../../../../shared/views/widgets/custom_text_input.widget.dart';
import '../../../../shared/views/widgets/nikel_logo.widget.dart';
import '../../../../theme/app_colors.dart';
import 'register.store.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _store = RegisterStore();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: appColors.primaryColor,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const NikelLogo(
              width: 70,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Registre-se',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: appColors.primaryColor,
                  ),
                ),
              ),
              Column(
                children: [
                  CustomTextInput(
                    controller: _emailController,
                    label: 'Digite seu e-mail',
                  ),
                  const SizedBox(height: 15),
                  CustomPasswordInput(
                    controller: _passController,
                    label: 'Digite sua senha',
                  ),
                  const SizedBox(height: 15),
                  CustomPasswordInput(
                    controller: _confirmPassController,
                    label: 'Confirme sua senha',
                    validator: (value) {
                      if (value != _passController.text) {
                        return 'Senhas não são iguais';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Observer(
                builder: (_) {
                  return CustomButton(
                    label: 'Criar conta',
                    isLoading: _store.isLoading,
                    onPressed: createAccount,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createAccount() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text;
    final pass = _passController.text;

    await _store.createAccount(email: email, pass: pass);

    if (_store.error != null) {
      ErrorModal.show(context: context, message: _store.error!);
      return;
    }

    if (!mounted) return;

    Navigator.pop(context);
  }
}
