import 'package:flutter/material.dart';
import 'package:medconnect/configs/custom_colors.dart';
import 'package:medconnect/utils/validators.dart';
import 'package:medconnect/views/auth/controller/auth_controller.dart';
import 'package:medconnect/views/auth/widgets/custom_divider.dart';
import 'package:medconnect/views/auth/widgets/custom_text_field.dart';
import 'package:medconnect/views/components/custom_button_border.dart';
import 'package:medconnect/views/components/custom_button_filled.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const routeName = '/singIn';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool loading = false;

  signIn() async {
    setState(() => loading = true);
    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      await context.read<AuthController>().signIn(email, password);
    } on AuthException catch (error) {
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
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF589CCE),
                Color(0xFF437BA4),
                Color(0xFF042F4D),
              ],
            ),
          ),
          child: Column(
            children: [
              Flexible(
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 32,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
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
                        onPressed: () => Navigator.of(context).pushNamed(SignInPage.routeName),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
