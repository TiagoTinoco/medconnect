import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medconnect/error_page.dart';

import 'package:medconnect/views/auth/controller/auth_controller.dart';
import 'package:medconnect/views/auth/sign_in_page.dart';
import 'package:medconnect/views/components/loading.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  static const routeName = '/';

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    AuthController auth = Provider.of<AuthController>(context);

    if (auth.isLoading) {
      return const Loading();
    } else if (auth.user == null) {
      return const SignInPage();
    } else {
      return const ErrorPage();
    }
  }
}
