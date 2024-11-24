import 'package:flutter/material.dart';
import 'package:medconnect/configs/snackbar_helper.dart';

import 'package:medconnect/utils/validators.dart';
import 'package:medconnect/views/components/custom_button_border.dart';
import 'package:medconnect/views/components/custom_button_filled.dart';
import 'package:medconnect/controller/auth_controller.dart';

import 'package:medconnect/views/auth/widgets/custom_divider.dart';
import 'package:medconnect/views/components/custom_text_field.dart';
import 'package:medconnect/views/auth/widgets/scaffold_bottom_form.dart';
import 'package:medconnect/views/auth/sign_up_page.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const routeName = '/singIn';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final _authController = context.read<AuthController>();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool loading = false;

  signIn() async {
    setState(() => loading = true);
    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      await _authController.signIn(email, password);
    } on GenericException catch (error) {
      // ignore: use_build_context_synchronously
      SnackbarHelper.showSnackbar(
        context: context,
        message: error.message,
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
              icon: Icons.email_outlined,
              label: 'E-mail',
              controller: _emailController,
              validator: emailValidator,
              textInputType: TextInputType.emailAddress,
            ),
            CustomTextField(
              icon: Icons.lock_outline,
              label: 'Password',
              controller: _passwordController,
              validator: passwordValidator,
              isSecret: true,
            ),
            const CustomDivider(),
            const SizedBox(height: 10),
            CustomButtonFilled(
              title: loading ? 'Carregando...' : 'Entrar',
              onPressed: !loading
                  ? () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        await signIn();
                      }
                    }
                  : () {},
            ),
            const SizedBox(height: 10),
            CustomButtonBorder(
              title: 'Cadastrar-se',
              onPressed: () => Navigator.of(context).pushNamed(SignUpPage.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
