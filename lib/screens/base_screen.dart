import 'package:flutter/material.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/screens/home_screen.dart';
import 'package:laravel_api/screens/login_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: FutureBuilder(
        future: auth.getToken(),
        builder: (context, snap) {
          return auth.isAuthenticated
              ? const HomeScreen()
              : const LoginScreen();
        },
      ),
    );
  }
}
