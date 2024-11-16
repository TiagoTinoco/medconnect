import 'package:flutter/material.dart';

class ScaffoldBottomForm extends StatelessWidget {
  const ScaffoldBottomForm({
    super.key,
    required this.form,
  });

  final Form form;

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
                child: form,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
