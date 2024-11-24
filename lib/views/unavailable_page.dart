import 'package:flutter/material.dart';
import 'package:medconnect/configs/custom_colors.dart';

class UnavailablePage extends StatelessWidget {
  const UnavailablePage({super.key});

  static const routeName = '/unavailable';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Text(
          'Pagina Indisponível',
          style: TextStyle(
            fontSize: 22,
            color: CustomColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
