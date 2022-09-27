import 'package:flutter/material.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  const LoginButton({Key? key, required this.email, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        SizedBox(
          width: size.width * 0.3,
          height: size.height * 0.035,
          child: MaterialButton(
              color: Colors.purple,
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                authProvider.login( email.text.toString(),password.text.toString(),context);
              }),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/RegisterScreen');
            },
            child: const Text(
              'Register',
              style:  TextStyle(color: Colors.purple),
            ))
      ],
    );
  }
}
