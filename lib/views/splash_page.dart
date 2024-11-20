import 'package:flutter/material.dart';

import 'package:medconnect/views/auth/auth.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = '';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.wait(
      [Future<void>.delayed(const Duration(milliseconds: 2000))],
    ).then((_) async {
      await Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return SizeTransition(
              sizeFactor: animation,
              child: const Auth(),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Image.asset(
              'assets/images/logo.png',
              semanticLabel: 'Logo do MedConnect',
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
}
