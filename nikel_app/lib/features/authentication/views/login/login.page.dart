import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/views/modals/error.modal.dart';
import '../../../../shared/views/widgets/custom_button.widget.dart';
import '../../../../shared/views/widgets/custom_password_input/custom_password_input.widget.dart';
import '../../../../shared/views/widgets/custom_text_input.widget.dart';
import '../../../../shared/views/widgets/growdev_logo.widget.dart';
import '../../../../shared/views/widgets/nikel_logo.widget.dart';
import '../../../../theme/app_colors.dart';
import '../../../releases/views/releases.page.dart';
import '../register/register.page.dart';
import 'login.store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _store = LoginStore();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColor = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const NikelLogo(),
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
                  Observer(builder: (context) {
                    return CustomButton(
                      onPressed: login,
                      label: 'Entrar',
                      isLoading: _store.isLoading,
                    );
                  }),
                  const SizedBox(height: 15),
                  Text.rich(
                    TextSpan(
                      text: 'Ainda não tem conta? ',
                      children: [
                        TextSpan(
                          text: 'Criar conta',
                          style: TextStyle(
                            color: appColor.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const RegisterPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const GrowdevLogo(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text;
    final pass = _passController.text;

    await _store.login(email: email, pass: pass);

    if (_store.error != null) {
      ErrorModal.show(context: context, message: _store.error!);
      return;
    }

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ReleasesPage(),
      ),
    );
  }
}
