import 'package:flutter/material.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/providers/categories_provider.dart';
import 'package:laravel_api/providers/transactions_provider.dart';
import 'package:laravel_api/screens/base_screen.dart';
import 'package:laravel_api/screens/categories_screen.dart';
import 'package:laravel_api/screens/home_screen.dart';
import 'package:laravel_api/screens/login_screen.dart';
import 'package:laravel_api/screens/register_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(builder: (context, auth, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CategoriesProvider()),
            ChangeNotifierProvider(create: (context) => TransactionsProvider()),
            ChangeNotifierProvider(create: (context) => AuthProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/LoginScreen': (context) => const LoginScreen(),
              '/RegisterScreen': (context) => const RegisterScreen(),
              '/HomeScreen': (context) => const HomeScreen(),
              '/CategoriesScreen': (context) => const CategoriesScreen(),
            },
            home: const BaseScreen()
          ),
        );
      }),
    );
  }
}
