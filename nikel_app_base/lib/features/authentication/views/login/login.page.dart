import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../shared/views/widgets/custom_button.widget.dart';
import '../../../../shared/views/widgets/custom_input/custom_input.widget.dart';
import '../../../../shared/views/widgets/error.modal.dart';
import '../../../../shared/views/widgets/logo_growdev.widget.dart';
import '../../../../themes/app_colors.dart';
import '../../../releases/releases.page.dart';
import '../register/register.page.dart';
import 'login.store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final store = LoginStore(GetIt.I());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _doLogin() async {
    _formKey.currentState?.validate();

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final result = await store.login(
        email: emailController.text,
        password: passwordController.text,
      );

      if (result && mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const ReleasesPage(),
          ),
          (_) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Image.asset(
                  'assets/nikel_logo.png',
                  width: 150,
                ),
              ),
              Column(
                children: [
                  Observer(builder: (_) {
                    if (store.failure != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ErrorModal.show(
                          context: context,
                          message: store.failure!,
                          onTap: () => store.clearFailure(),
                        );
                      });
                    }

                    return const SizedBox.shrink();
                  }),
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
                  const SizedBox(height: 20),
                  Observer(builder: (_) {
                    return CustomButton(
                      text: 'Entrar',
                      onPressed: () async => _doLogin(),
                      isLoading: store.isLoading,
                    );
                  }),
                  const SizedBox(height: 15),
                  Text.rich(
                    TextSpan(text: 'Ainda não tem conta? ', children: [
                      TextSpan(
                        text: 'Criar conta',
                        style: TextStyle(color: appColors.primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const RegisterPage(),
                              ),
                            );
                          },
                      ),
                      const TextSpan(text: '.'),
                    ]),
                  ),
                ],
              ),
              const LogoGrowdev(),
            ],
          ),
        ),
      ),
    );
  }
}
