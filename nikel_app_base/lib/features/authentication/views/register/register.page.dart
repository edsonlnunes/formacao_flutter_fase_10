import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../shared/views/widgets/custom_button.widget.dart';
import '../../../../shared/views/widgets/custom_input/custom_input.widget.dart';
import '../../../../themes/app_colors.dart';
import 'register.store.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final store = RegisterStore(GetIt.I());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _doRegister() async {
    _formKey.currentState?.validate();

    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text) {
      final result = await store.register(
        email: emailController.text,
        password: passwordController.text,
      );

      if (result && mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: appColors.primaryColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/nikel_logo.png',
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Registre-se',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: appColors.primaryColor,
                  ),
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    controller: emailController,
                    hintText: 'Digite seu e-mail',
                    label: 'E-mail',
                  ),
                  const SizedBox(height: 15),
                  CustomInput(
                    controller: passwordController,
                    hintText: 'Digite sua senha',
                    label: 'Senha',
                    isPassword: true,
                  ),
                  const SizedBox(height: 15),
                  CustomInput(
                    controller: confirmPasswordController,
                    hintText: 'Confirme sua senha',
                    label: 'Confirmar senha',
                    isPassword: true,
                    validator: (_) {
                      if (confirmPasswordController.text.isEmpty) {
                        return 'Preencha este campo';
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Observer(builder: (_) {
                return CustomButton(
                  text: 'Criar conta',
                  onPressed: () async => _doRegister(),
                  isLoading: store.isLoading,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
