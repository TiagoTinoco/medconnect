import 'package:flutter/material.dart';
import 'package:medconnect/configs/custom_colors.dart';
import 'package:medconnect/views/components/custom_list_tile.dart';
import 'package:medconnect/views/profile_page.dart';
import 'package:medconnect/views/unavailable_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: CustomColors.primary,
          title: const Text(
            'Configuração',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        const SliverToBoxAdapter(
          child: Column(
            children: [
              CustomListTile(
                title: 'Dados do Perfil',
                routeName: ProfilePage.routeName,
              ),
              CustomListTile(
                title: 'Gerenciamento',
                routeName: UnavailablePage.routeName,
              ),
              CustomListTile(
                title: 'Histórico de Notificações',
                routeName: UnavailablePage.routeName,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
