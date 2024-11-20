import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:medconnect/views/bottom_navigator.dart';

import 'package:medconnect/utils/validators.dart';
import 'package:medconnect/model/user_model.dart';

import 'package:medconnect/views/components/custom_button_border.dart';
import 'package:medconnect/views/components/custom_button_filled.dart';

import 'package:medconnect/views/auth/controller/auth_controller.dart';
import 'package:medconnect/views/auth/widgets/custom_divider.dart';
import 'package:medconnect/views/auth/widgets/custom_text_field.dart';
import 'package:medconnect/views/auth/widgets/scaffold_bottom_form.dart';
import 'package:medconnect/views/home_page.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static const routeName = '/singUp';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = MaskedTextController(mask: '(00) 00000-0000');

  bool loading = false;

  signUp() async {
    setState(() => loading = true);
    try {
      final email = _emailController.text;
      final name = _nameController.text;
      final password = _passwordController.text;
      final phoneNumber = _phoneNumberController.text;

      await context.read<AuthController>().signUp(
            UserModel(
              name: name,
              email: email,
              phoneNumber: phoneNumber,
              isDoctor: false,
            ),
            password,
          );

      // ignore: use_build_context_synchronously
      await Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return SizeTransition(
              sizeFactor: animation,
              child: const BottomNavigator(),
            );
          },
        ),
      );
    } on AuthException catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF0F0F0F).withOpacity(0.9),
          content: Center(child: Text(error.message)),
        ),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBottomForm(
      form: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              icon: Icons.person_outlined,
              label: 'Nome',
              controller: _nameController,
              validator: nameValidator,
              textInputType: TextInputType.name,
            ),
            CustomTextField(
              icon: Icons.email_outlined,
              label: 'E-mail',
              controller: _emailController,
              validator: emailValidator,
              textInputType: TextInputType.emailAddress,
            ),
            CustomTextField(
              icon: Icons.lock_outline,
              label: 'Senha',
              controller: _passwordController,
              validator: passwordValidator,
              isSecret: true,
            ),
            CustomTextField(
              icon: Icons.lock_outline,
              label: 'Telefone',
              controller: _phoneNumberController,
              validator: phoneValidator,
            ),
            const CustomDivider(),
            const SizedBox(height: 10),
            CustomButtonFilled(
              title: loading ? 'Criando...' : 'Criar',
              onPressed: !loading
                  ? () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        await signUp();
                      }
                    }
                  : () {},
            ),
            const SizedBox(height: 10),
            CustomButtonBorder(
              title: 'Voltar',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
