import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medconnect/firebase_options.dart';
import 'package:medconnect/views/auth/sign_up_page.dart';
import 'package:medconnect/views/home_page.dart';
import 'package:provider/provider.dart';

import 'views/auth/controller/auth_controller.dart';

import 'package:medconnect/splash_page.dart';
import 'package:medconnect/views/auth/auth.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
      ],
      child: MaterialApp(
        title: 'MedConnect',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (_) => const SplashPage(),
          Auth.routeName: (_) => const Auth(),
          SignInPage.routeName: (_) => const SignInPage(),
          SignUpPage.routeName: (_) => const SignUpPage(),
          HomePage.routeName: (_) => const HomePage(),
        },
      ),
    );
  }
}
