import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medconnect/views/auth/auth.dart';
import 'package:medconnect/views/components/custom_button_border.dart';
import 'package:medconnect/views/components/custom_button_filled.dart';
import 'package:provider/provider.dart';
import 'package:medconnect/configs/custom_colors.dart';

import 'package:medconnect/controller/user_controller.dart';
import 'package:medconnect/views/components/custom_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final _userController = context.read<UserController>();

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Text(
            'Excluir Conta',
            style: TextStyle(
              fontSize: 22,
              color: CustomColors.primary,
            ),
          ),
          content: const Text(
            'Você tem certeza de que deseja excluir todos os dados da sua conta? Todos os seus dados serão perdidos e não tem como serem recuperados.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF333333),
            ),
          ),
          actions: <Widget>[
            CustomButtonBorder(
              onPressed: () => Navigator.of(context).pop(),
              title: 'Cancelar',
              height: 40,
              width: 140,
            ),
            CustomButtonFilled(
              onPressed: () => reauthenticateAndDeleteUser(context),
              title: 'Sim',
              height: 40,
              width: 82.7,
              backgroundColor: CustomColors.warning,
            ),
          ],
        );
      },
    );
  }

  Future<void> reauthenticateAndDeleteUser(BuildContext context) async {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Text(
            'Excluir Conta',
            style: TextStyle(
              fontSize: 22,
              color: CustomColors.primary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            CustomButtonBorder(
              onPressed: () => Navigator.of(context).pop(),
              title: 'Voltar',
              height: 40,
              width: 110,
            ),
            CustomButtonFilled(
              onPressed: () async {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                if (email.isNotEmpty && password.isNotEmpty) {
                  try {
                    final credential = EmailAuthProvider.credential(
                      email: email,
                      password: password,
                    );

                    await _userController.deleteUser(credential);

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Auth.routeName,
                      (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Erro ao tentar reautenticar.')),
                    );
                  }
                }
              },
              title: 'Pronto',
              height: 40,
              width: 110,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: CustomColors.primary,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              'Dados do Perfil',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Nome',
                    readOnly: true,
                    initialValue: _userController.name,
                  ),
                  CustomTextField(
                    label: 'E-mail',
                    readOnly: true,
                    initialValue: _userController.email,
                  ),
                  CustomTextField(
                    label: 'Telefone',
                    readOnly: true,
                    initialValue: _userController.phoneNumber,
                  ),
                  CustomTextField(
                    label: 'Número da Carteirinha',
                    readOnly: true,
                    initialValue: _userController.cardNumber,
                  ),
                  const SizedBox(height: 20),
                  CustomButtonFilled(
                    onPressed: () => _showPopup(context),
                    title: 'Deletar Conta',
                    backgroundColor: CustomColors.warning.withOpacity(0.9),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
