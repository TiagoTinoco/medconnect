import 'package:flutter/material.dart';
import 'package:medconnect/configs/custom_colors.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: CustomColors.primary,
          title: const Text(
            'Agenda',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Center(
              child: Text(
                'Pagina Indisponível',
                style: TextStyle(
                  fontSize: 22,
                  color: CustomColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
