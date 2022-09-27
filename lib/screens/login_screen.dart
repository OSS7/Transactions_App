import 'package:flutter/material.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/widgets/custom_text_field.dart';
import 'package:laravel_api/widgets/login_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          width: size.width * 0.9,
          height: size.height * 0.5,
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transaction App ',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.purple, fontSize: 30),
              ),
              CustomTextField(
                controller: _email,
                hint: 'Email',
              ),
              CustomTextField(
                controller: _password,
                hint: 'Password',
              ),
              LoginButton(email: _email, password: _password),
            ],
          ),
        ),
      ),
    );
  }
}
