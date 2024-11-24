import 'package:flutter/material.dart';
import 'package:medconnect/views/common/reminder_page.dart';
import 'package:medconnect/views/schedule_appointment_page.dart';
import 'package:medconnect/views/unavailable_page.dart';
import 'package:provider/provider.dart';

import 'package:medconnect/configs/custom_colors.dart';
import 'package:medconnect/controller/user_controller.dart';

class _BoxButtonModel {
  _BoxButtonModel({
    required this.title,
    required this.routeName,
  });

  final String title;
  final String routeName;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'routeName': routeName,
    };
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _userController = context.read<UserController>();

  final List<Map<String, dynamic>> boxButtons = [
    _BoxButtonModel(
      title: 'Agendar Consulta',
      routeName: ScheduleAppointmentPage.routeName,
    ).toMap(),
    _BoxButtonModel(
      title: 'Consultas Agendadas',
      routeName: UnavailablePage.routeName,
    ).toMap(),
    _BoxButtonModel(
      title: 'Iniciar Chat',
      routeName: UnavailablePage.routeName,
    ).toMap(),
    _BoxButtonModel(
      title: 'Histórico',
      routeName: UnavailablePage.routeName,
    ).toMap(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userController.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

        if (snapshot.hasError) return Center(child: Text("Erro: ${snapshot.error}"));

        final user = _userController;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: CustomColors.primary,
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: CustomColors.grey,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        semanticLabel: 'Logo do MedConnect',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'NC: ${user.cardNumber}',
                        style: TextStyle(
                          fontSize: 14,
                          color: CustomColors.secondary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height * 0.35),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: boxButtons.length,
                      itemBuilder: (context, index) {
                        final boxButton = boxButtons[index];
                        return BoxButton(
                          title: boxButton['title'],
                          routeName: boxButton['routeName'],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ReminderPage(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class BoxButton extends StatelessWidget {
  const BoxButton({
    super.key,
    required this.title,
    required this.routeName,
  });

  final String title;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(routeName),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: CustomColors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
