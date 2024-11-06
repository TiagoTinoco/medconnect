import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medconnect/firebase_options.dart';
import 'package:medconnect/views/auth/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MedConnect());
}

class MedConnect extends StatelessWidget {
  const MedConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedConnect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SignInPage.routeName,
      routes: {
        SignInPage.routeName: (_) => const SignInPage(),
      },
    );
  }
}
